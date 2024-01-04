import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../Screen/Cityname.dart';

class Localdata extends StatefulWidget {
  final data;
   Localdata(this.data, {super.key});

  @override
  State<Localdata> createState() => _LocaldataState();
}

class _LocaldataState extends State<Localdata> {

  bool unit=false;


  unitchange(){
    setState(
          () {
        unit = !unit;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        Text(widget.data[0]['addrese'].toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13,color: Colors.white)),
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
                      1:FlexColumnWidth(4),
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
                              child: Text(unit?((widget.data[0]['currenttemp'] * 9/5) + 32).toString():widget.data[0]['currenttemp'].toString(),maxLines: 1, style: TextStyle(fontSize:68,color: Colors.white,fontWeight: FontWeight.w400),)),

                          Align(
                              alignment:Alignment.topLeft,
                              child: Text(unit?'°F':widget.data[0]['currentunit'].toString(),maxLines: 1, style: TextStyle(fontSize:68,color: Colors.white,fontWeight: FontWeight.w400),)),

                          Icon(Icons.cloudy_snowing,color: Colors.white,size: 110,)
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
                                  Text(widget.data[0]['utc'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

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
                                      child: Text(widget.data[0]['timezone'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),)),

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
                                  Text(widget.data[0]['timeabbr'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),),

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
                                      child: Text(widget.data[0]['elevation'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400),)),

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
                                   Icon(Icons.cloud,color: Colors.white,size: 85,),
                                Row(
                                  children: [
                                    Text(unit?((widget.data[0]['temperaturemin0'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperaturemin0'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
                                    Icon(Icons.vertical_align_bottom,color: Colors.white,),
                                    Text(unit?((widget.data[0]['temperatuemax0'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperatuemax0'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
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

                                        Text(widget.data[0]['sunrise0'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),

                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.sunny_snowing,color: Colors.yellow,),
                                        Text(widget.data[0]['sunset0'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),


                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.data[0]['sunset0'].substring(0,10).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 20,
                                ),

                                // Text(state.model.daily.time[i].substring(0,10).toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),

                              ],
                            ),
                          ),
                        ),
                      ),

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
                                Icon(Icons.cloud,color: Colors.white,size: 85,),
                                Row(
                                  children: [
                                    Text(unit?((widget.data[0]['temperaturemin1'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperaturemin1'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
                                    Icon(Icons.vertical_align_bottom,color: Colors.white,),
                                    Text(unit?((widget.data[0]['temperatuemax1'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperatuemax1'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
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

                                        Text(widget.data[0]['sunrise1'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),

                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.sunny_snowing,color: Colors.yellow,),
                                        Text(widget.data[0]['sunset1'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),


                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.data[0]['sunset1'].substring(0,10).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 20,
                                ),

                                // Text(state.model.daily.time[i].substring(0,10).toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),

                              ],
                            ),
                          ),
                        ),
                      ),

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
                                Icon(Icons.cloud,color: Colors.white,size: 85,),
                                Row(
                                  children: [
                                    Text(unit?((widget.data[0]['temperaturemin2'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperaturemin2'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
                                    Icon(Icons.vertical_align_bottom,color: Colors.white,),
                                    Text(unit?((widget.data[0]['temperatuemax2'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperatuemax2'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
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

                                        Text(widget.data[0]['sunrise2'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),

                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.sunny_snowing,color: Colors.yellow,),
                                        Text(widget.data[0]['sunset2'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),


                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.data[0]['sunset2'].substring(0,10).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 20,
                                ),

                                // Text(state.model.daily.time[i].substring(0,10).toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),

                              ],
                            ),
                          ),
                        ),
                      ),

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
                                Icon(Icons.cloud,color: Colors.white,size: 85,),
                                Row(
                                  children: [
                                    Text(unit?((widget.data[0]['temperaturemin3'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperaturemin3'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
                                    Icon(Icons.vertical_align_bottom,color: Colors.white,),
                                    Text(unit?((widget.data[0]['temperatuemax3'] * 9/5) + 32).toString().substring(0,4):widget.data[0]['temperatuemax3'].toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),
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

                                        Text(widget.data[0]['sunrise3'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),

                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.sunny_snowing,color: Colors.yellow,),
                                        Text(widget.data[0]['sunset3'].substring(11,16).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),


                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.data[0]['sunset3'].substring(0,10).toString(),style: TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.w400)),
                                SizedBox(
                                  height: 20,
                                ),

                                // Text(state.model.daily.time[i].substring(0,10).toString(),style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w400)),

                              ],
                            ),
                          ),
                        ),
                      ),



                    ],
                  ),
                )

              ],
            )
        ),
      ),
    );
  }
}
