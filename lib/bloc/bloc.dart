import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weature/bloc/weature_event.dart';
import 'package:weature/bloc/weature_state.dart';

import '../Repo.dart';


class WeatBloc extends Bloc<WeatEvent,WeatState>{
  final WebServise webServise;
  WeatBloc(this.webServise):super(ProfileInitiate()){
    on<getdataEvent>((event, emit) => _callApi(event,emit));
  }
  _callApi(getdataEvent event,Emitter<WeatState> emit)async{

    try{
      emit(ProfileInitiate());
      var data = await webServise.getwearuredata(event.lat,event.lon);
      emit(ProductSuccess(data));
    }
    catch(e){
      print(e.toString());
      emit(ProductError("$e"));
    }

  }
}