import 'package:flutter_app/blocs/loginBloc/login_event.dart';
import 'package:flutter_app/blocs/loginBloc/login_state.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  UserRepository userRepository;

  LoginBloc(){
    userRepository = UserRepository();
  }

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
      try{
        if(event is LoginButtonPressedEvent) {
          yield LoginLoadingState();
          var user = await userRepository.signInUser(
              event.email, event.password);
          yield LoginSuccessfulState(user: user);
        }
      }catch(e){
        yield LoginFailureState(msg: e.toString());
      }
  }
}