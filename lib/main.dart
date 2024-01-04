import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weature/theme.dart';

import 'Repo.dart';
import 'Screen/Cityname.dart';
import 'Screen/weaturescrren.dart';
import 'bloc/bloc.dart';


void main() {
  runApp(RepositoryProvider(
      create: (context)=>WebServise(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: Colors.white,
          errorColor: Color.fromRGBO(46, 67, 116, 1),
          colorScheme: ThemeData().colorScheme.copyWith(
            primary:Color.fromRGBO(46, 67, 116, 1),
          ),
          primaryColor: Colors.red,
        ),
        home:  MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {



  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>BlocProvider(
                  create: (context)=>WeatBloc(WebServise()),
                  child: WeatureScreen()),
            )));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red ,
      body: Container(

        decoration:  BoxDecoration(
          color: Mytheme().primary,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Kanishka Software Pvt Ltd',textAlign:TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w500),),
          ),
        ),
      ),
    );
  }
}
