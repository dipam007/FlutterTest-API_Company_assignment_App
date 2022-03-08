import 'package:bloc/bloc.dart';
import 'package:flutter_app/blocs/authBloc/auth_event.dart';
import 'package:flutter_app/blocs/authBloc/auth_state.dart';
import 'package:flutter_app/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  UserRepository userRepository;

  AuthBloc(){
    userRepository = UserRepository();
  }

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is AppStartedEvent){
      try{
        var isSignedIn = await userRepository.isSignedIn();
        if(isSignedIn){
          var user = await userRepository.getCurrentUser();
          yield AuthenticatedState(user: user);
        }
        else{
          yield UnAuthenticatedState();
        }
      }catch(e){
        yield UnAuthenticatedState();
      }
    }
  }

}