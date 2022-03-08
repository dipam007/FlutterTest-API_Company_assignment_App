import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable{}

class RegisterInitialState extends RegisterState{
  @override
  List<Object> get props => throw UnimplementedError();
}

class RegisterLoadingState extends RegisterState{
  @override
  List<Object> get props => throw UnimplementedError();
}

class RegisterSuccessfulState extends RegisterState{

  final User user;

  RegisterSuccessfulState({@required this.user});

  @override
  List<Object> get props => throw UnimplementedError();
}

class RegisterFailureState extends RegisterState{

  final String msg;

  RegisterFailureState({@required this.msg});

  @override
  List<Object> get props => throw UnimplementedError();
}