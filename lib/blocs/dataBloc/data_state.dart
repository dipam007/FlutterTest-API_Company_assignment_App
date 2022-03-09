 import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/model/api_result_model.dart';
import 'package:meta/meta.dart';

abstract class DataState extends Equatable{}

class DataInitialState extends DataState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DataLoadingState extends DataState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DataLoadedState extends DataState{

  List<Welcome> list;

  DataLoadedState({@required this.list});

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class DataErrorState extends DataState{

  String msg;

  DataErrorState({@required this.msg});

  @override
  // TODO: implement props
  List<Object> get props => [msg];
}




