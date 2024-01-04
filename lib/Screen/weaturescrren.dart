import 'dart:ffi';

import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weature/Repo.dart';
import 'package:weature/Screen/Cityname.dart';
import 'package:weature/localstorageweature/sqldatapage.dart';

import '../Model/WeatureModel.dart';
import '../bloc/bloc.dart';
import '../bloc/weature_event.dart';
import '../bloc/weature_state.dart';
import '../localstorageweature/sqldata.dart';

class WeatureScreen extends StatefulWidget {
  final city;
  final state;
  final country;
  final lat;
  final lon;

   WeatureScreen({Key? key,  this.lat, this.lon, this.city, this.state, this.country,}) : super(key: key);

  @override
  State<WeatureScreen> createState() => _WeatureScreenState();
}

class _WeatureScreenState extends State<WeatureScreen> {
  bool unit=false;
  String? currentAddress;
  Position? currentPosition;

  @override
  void initState() {
    _refreshJournals1();
    if(widget.country==null){
       checcknet();
    }
   else{
    getdata();}
    // TODO: implement initState
    super.initState();
  }

  deletdata()async{
    await SQLHe.deleteAll();
    print('deleted');
  }

 checcknet()async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
    _getCurrentPosition();  }
  else{
    Fluttertoast.showToast(msg: "No internet Connection");
  }
}

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        _getAddressFromLatLng(currentPosition!);
        getlocationdata();

      }
      );
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  List<Map<String, dynamic>> _journals1 = [];
  bool _isLooading1 = true;


  void _refreshJournals1() async {
    final data = await SQLHe.getItems();
    setState(() {
      _journals1 = data;
      _isLooading1 = false;
    });
  }

  Future<void> _addItem1(state) async {
    // await SQLHe.deleteItem(0);
    await SQLHe.createItem(
        widget.city??currentAddress,
        widget.lat??currentPosition!.latitude,
        widget.lon??currentPosition!.longitude,
        state.model.utcOffsetSeconds,
        state.model.timezone,
        state.model.timezoneAbbreviation,
        state.model.elevation.toString(),
        state.model.current.temperature2M,
        state.model.currentUnits.temperature2M,

        state.model.daily.weathercode[0],
        state.model.daily.temperature2MMax[0],
        state.model.daily.temperature2MMin[0],
        state.model.daily.sunrise[0],
        state.model.daily.sunset[0],

      state.model.daily.weathercode[1],
      state.model.daily.temperature2MMax[1],
      state.model.daily.temperature2MMin[1],
      state.model.daily.sunrise[1],
      state.model.daily.sunset[1],

      state.model.daily.weathercode[2],
      state.model.daily.temperature2MMax[2],
      state.model.daily.temperature2MMin[2],
      state.model.daily.sunrise[2],
      state.model.daily.sunset[2],

      state.model.daily.weathercode[3],
      state.model.daily.temperature2MMax[3],
      state.model.daily.temperature2MMin[3],
      state.model.daily.sunrise[3],
      state.model.daily.sunset[3]

    );
    _refreshJournals1();
  }

  unitchange(){
    setState(
          () {
            unit = !unit;
      },
    );
  }
  getlocationdata(){

      context.read<WeatBloc>().add(getdataEvent(currentPosition!.latitude,currentPosition!.longitude));


  }

  getdata(){

    context.read<WeatBloc>().add(getdataEvent(widget.lat,widget.lon));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(46, 67, 116, 1),

      body:BlocConsumer <WeatBloc,WeatState>(
          builder:(context,state){
            print('fgcf'+_journals1.length.toString());

            if(state is ProductLoading){
               _journals1.length==0?CircularProgressIndicator(
                color: Colors.yellow,
              ) :Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircularProgressIndicator(color: Colors.white,),
                  Align(
                      alignment: Alignment.center,
                      child: Text('Loading ...',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),)),

                ],
              ));

            }
            if(state is ProductSuccess){

              return RefreshIndicator(
                  onRefresh: () {
                    return getdata();

                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Container(
       child: Column(
        children: [

      SizedBox(
        height: 60,
      ),
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(20)
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(Icons.location_on_outlined,color: Colors.white,),

        widget.country==null?Text(currentAddress.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13,color: Colors.white)):Text(widget.city.toString()+" "+widget.state.toString()+" "+widget.country.toString(),maxLines:1,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 13,color: Colors.white),)
      ],
    ),
  ),
),
          SizedBox(
            height: 15,
          ),
          Container(

            child: Table(
              columnWidths: {
                0:FlexColumnWidth(2),
                1:FlexColumnWidth(6),
                2:FlexColumnWidth(2)
              },
              children: [
                TableRow(
                  children: [
            Switch(
            onChanged: (u){
              unitchange();
            },
              value: unit,
              activeColor: Colors.white,
              activeTrackColor: Colors.black,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.black,
            ),

                          InkWell(
                        onTap:(){
                          unitchange();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:8,bottom: 8,right: 15),
                          child: Container(

                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(unit?'Change to Celsius':'Change to Fahrenheit',style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
                              )),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child:IconButton(onPressed: (){
                          
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CityNmae()));
                        }, icon: Icon(Icons.search,color: Colors.white,),)  ),
                    )

                  ]
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),

Table(
  columnWidths: {
    0:FlexColumnWidth(4),
    1:FlexColumnWidth(2),
    2:FlexColumnWidth(3)

  },
  children: [
    TableRow(
      children: [


                        Align(
      alignment:Alignment.topLeft,
      child: Text(unit?((state.model.current.temperature2M * 9/5) + 32).toString():state.model.current.temperature2M.toString(),maxLines: 1, style: TextStyle(fontSize:68,color: Colors.white,fontWeight: FontWeight.w400),)),

        Align(
            alignment:Alignment.topLeft,
            child: Text(unit?'°F':state.model.currentUnits.temperature2M.toString(),maxLines: 1, style: TextStyle(fontSize:68,color: Colors.white,fontWeight: FontWeight.w400),)),

        Icon(Icons.cloud,color: Colors.white,size: 110,)
      ]
    )
  ],
),
     SizedBox(
       height: 20,
     )           , // Text(state.model.timezone.toString()),
Table(
  children: [
    TableRow(
      children: [

      Align(
        alignment:Alignment.topLeft,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text("Utc offset seconds",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),),
        Text(state.model.utcOffsetSeconds.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

      ],
        )),
      Align(
        alignment:Alignment.topRight,
        child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Align(
            alignment:Alignment.topRight,
            child: Text("Timezone",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),)),
        Align(
            alignment:Alignment.topRight,
            child: Text(state.model.timezone.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),)),

      ],
        )),

      ]
    ),

  ],
),
      SizedBox(
        height: 30,
      ),
      Table(
        children: [

          TableRow(
              children: [

                    Align(
                        alignment:Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Timezone abbreviation",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),),
                            Text(state.model.timezoneAbbreviation.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

                          ],
                        )),
                    Align(
                        alignment:Alignment.topRight,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Align(
                                alignment:Alignment.topRight,
                                child: Text("Elevation",style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400),)),
                            Align(
                                alignment:Alignment.topRight,
                                child: Text(state.model.elevation.toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),)),

                          ],
                        )),

              ]
          ),
        ],
      ),
SizedBox(
  height: 50,
),
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child:   Row(
    children: [
      for(var i=0;i<state.model.daily.weathercode.length;i++)...[
      Padding(
      padding: const EdgeInsets.only(top:8,right: 8,bottom: 8),
      child: Container(
        decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(20)
        ),

        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          state.model.daily.weathercode[i]==0?Icon(Icons.cloud_off_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==1?Icon(Icons.cloud,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==2?Icon(Icons.cloud,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==3?Icon(Icons.cloud,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==45?Icon(Icons.foggy,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==48?Icon(Icons.foggy,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==51?Icon(Icons.light_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==55?Icon(Icons.light_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==53?Icon(Icons.light_outlined,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==61?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==63?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==65?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==66?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==67?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==71?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==73?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==75?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==77?Icon(Icons.snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==80?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==81?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==82?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==85?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==86?Icon(Icons.cloudy_snowing,color: Colors.grey,size: 85,):
          state.model.daily.weathercode[i]==82?Icon(Icons.thunderstorm,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==85?Icon(Icons.thunderstorm,color: Colors.white,size: 85,):
          state.model.daily.weathercode[i]==86?Icon(Icons.thunderstorm,color: Colors.white,size: 85,)


              :Icon(Icons.cloud,color: Colors.white,size: 85),

           Row(
             children: [
               Text(unit?((state.model.daily.temperature2MMin[i] * 9/5) + 32).toString().substring(0,4):state.model.daily.temperature2MMin[i].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
              Icon(Icons.vertical_align_bottom,color: Colors.white,),
               Text(unit?((state.model.daily.temperature2MMax[i] * 9/5) + 32).toString().substring(0,4):state.model.daily.temperature2MMax[i].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
               Icon(Icons.vertical_align_top,color: Colors.white,)
             ],
           ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                    children: [
                      Icon(Icons.sunny,color: Colors.yellow,),

                      Text(state.model.daily.sunrise[i].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),

                    ],
              ),
              SizedBox(
                    width: 10,
              ),
              Column(
                    children: [
                      Icon(Icons.sunny_snowing,color: Colors.yellow,),
                      Text(state.model.daily.sunset[i].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),


                    ],
              ),

            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(state.model.daily.sunset[i].substring(0,10).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),
          SizedBox(
            height: 20,
          ),

          // Text(state.model.daily.time[i].substring(0,10).toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),

        ],
      ),
        ),
      ),
      )
      ]
    ],
  ),
)

        ],
      )
      ),
                    ),
                  ),
                );
              
            }
            if(state is ProductError){
              return Text(state.msg);                    }
            return _journals1.length==0? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircularProgressIndicator(color: Colors.white,),
                Align(
                    alignment: Alignment.center,
                    child: Text('Loading ...',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),)),

              ],
            )):Localdata(
                _journals1
              // lat:_journals1[0]['latitude'],lon:_journals1[0]['longitude'],
              // utc:_journals1[0]['utc'],timezone:_journals1[0]['timezone'],
              // timeabbr:_journals1[0]['timeabbr'],elevation:_journals1[0]['elevation'],
              // temperaturemax0:_journals1[0]['temperatuemax0'], temperaturemin0:_journals1[0]['temperaturemin0'],
              // sunrise0:_journals1[0]['sunrise0'], sunset0:_journals1[0]['sunset0'],
              // weature:_journals1[0]['weature'],
              //
              // temperaturemax0:_journals1[0]['temperatuemax0'], temperaturemin0:_journals1[0]['temperaturemin0'],
              // sunrise0:_journals1[0]['sunrise0'], sunset0:_journals1[0]['sunset0'],
              // weature:_journals1[0]['weature'],
              //
              // temperaturemax0:_journals1[0]['temperatuemax0'], temperaturemin0:_journals1[0]['temperaturemin0'],
              // sunrise0:_journals1[0]['sunrise0'], sunset0:_journals1[0]['sunset0'],
              // weature:_journals1[0]['weature'],
              //
              // temperaturemax0:_journals1[0]['temperatuemax0'], temperaturemin0:_journals1[0]['temperaturemin0'],
              // sunrise0:_journals1[0]['sunrise0'], sunset0:_journals1[0]['sunset0'],
              // weature:_journals1[0]['weature'],
              //
              // temperaturemax0:_journals1[0]['temperatuemax0'], temperaturemin0:_journals1[0]['temperaturemin0'],
              // sunrise0:_journals1[0]['sunrise0'], sunset0:_journals1[0]['sunset0'],
              // weature:_journals1[0]['weature'],


            ) ;

          }, listener: (BuildContext context, WeatState state) {
            if(state is ProductSuccess){
              print('jshgbrhgb');
              deletdata();

              _addItem1(state);
            }
      },


      ),


    );
  }
}
