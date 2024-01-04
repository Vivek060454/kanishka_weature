import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
abstract class WeatEvent extends Equatable{
  const WeatEvent();
  @override
  List<Object?> get props =>[];
}
class getdataEvent extends WeatEvent{
  final lat;
  final lon;

  getdataEvent(this.lat,this.lon,);

  @override
  List<Object?> get props =>[];
}