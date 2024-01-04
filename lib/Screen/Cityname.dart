import 'package:connectivity/connectivity.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weature/Screen/weaturescrren.dart';

import '../Repo.dart';
import '../bloc/bloc.dart';
import '../theme.dart';

class CityNmae extends StatefulWidget {
  const CityNmae({Key? key}) : super(key: key);

  @override
  State<CityNmae> createState() => _CityNmaeState();
}

class _CityNmaeState extends State<CityNmae> {
  final _formKey = GlobalKey<FormState>();
  var countryValue;
  var stateValue;
  var cityValue;



  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Mytheme().primary,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(
                    height: 130,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Select Addrese',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),)),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              CSCPicker(
                              onCountryChanged: (value) {

                                setState(() {

                                  countryValue = value;
                                });
                              },
                              onStateChanged: (value) {
                                setState(() {
                                  stateValue = value;
                                });
                              },
                              onCityChanged: (value) {
                                setState(() {

                                  cityValue = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),



                            InkWell(
                              onTap: () async {
                                print('rg'+cityValue.toString()+stateValue.toString()+countryValue.toString());
                                if (cityValue==null||countryValue==null||stateValue==null){
                                  Fluttertoast.showToast(msg: "Select Addrese");
                                }
                                else{
                                  var connectivityResult = await (Connectivity().checkConnectivity());

                                  if (connectivityResult == ConnectivityResult.mobile||connectivityResult == ConnectivityResult.wifi) {
                                    List<Location>   locations = await locationFromAddress( cityValue.toString()+stateValue.toString()+countryValue.toString());
                                    if(locations.last.latitude!=null){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>BlocProvider(
                                                create: (context)=>WeatBloc(WebServise()),
                                                child: WeatureScreen( city:cityValue.toString(),state:stateValue.toString(),country:countryValue.toString(),lat:locations.last.latitude,lon:locations.last.longitude)),
                                          ));
                                    }
                                    else{
                                      Fluttertoast.showToast(msg: "Invalid addrese");
                                    }



                                  } else  {
                                    Fluttertoast.showToast(msg: "No internet Connection");

                                  }

                                }
                              },
                              child: Container(

                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  color: Mytheme().primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text('NEXT',

                                    style: TextStyle(fontSize: 20,
                                        color: Colors.white,
                                        letterSpacing: 3.0),
                                  ),
                                ),

                              ),
                            ),

                            ]),




                        ),
                      ),
                    ),
                ],
              ),
              ),
          ),
          ),
        );
  }

}