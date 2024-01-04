
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'Model/WeatureModel.dart';
class  WebServise{

  Future<Weature>getwearuredata(lat,lon)async{

    var url = Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=${lat}2&longitude=${lon}&current=temperature_2m&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=auto&past_days=3');
    var response;
    try{
       response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    }
    catch(e){
      print(e);
    }

    return weatureFromJson(response.body);
  }
}