import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class RegisterEvent extends Equatable{}

class SignUpButtonPressedEvent extends RegisterEvent{

  final String email, password;

  SignUpButtonPressedEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => throw UnimplementedError();
}