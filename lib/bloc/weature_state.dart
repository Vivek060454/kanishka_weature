import 'package:equatable/equatable.dart';


abstract class WeatState extends Equatable{
  const WeatState();
}
class ProfileInitiate extends WeatState{
  @override
  List<Object?> get props =>[];
}
class ProductLoading extends WeatState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductSuccess extends WeatState{
  final model;
  ProductSuccess(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [model];

}
class ProductError extends WeatState{
  final String msg;
  ProductError(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];

}