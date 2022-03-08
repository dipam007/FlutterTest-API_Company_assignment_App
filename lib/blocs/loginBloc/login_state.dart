import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable{}

class LoginInitialState extends LoginState{
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoginLoadingState extends LoginState{
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoginSuccessfulState extends LoginState{

  final User user;

  LoginSuccessfulState({@required this.user});

  @override
  List<Object> get props => throw UnimplementedError();
}

class LoginFailureState extends LoginState{

  final String msg;

  LoginFailureState({@required this.msg});

  @override
  List<Object> get props => throw UnimplementedError();
}