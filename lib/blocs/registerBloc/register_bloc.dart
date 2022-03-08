import 'package:flutter_app/blocs/registerBloc/register_event.dart';
import 'package:flutter_app/blocs/registerBloc/register_state.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{

  UserRepository userRepository;

  RegisterBloc(){
    userRepository = UserRepository();
  }

  @override
  RegisterState get initialState => RegisterInitialState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    try{
      if(event is SignUpButtonPressedEvent){
        yield RegisterLoadingState();
        var user = await userRepository.createUser(event.email, event.password);
        yield RegisterSuccessfulState(user: user);
      }
    }catch(e){
        yield RegisterFailureState(msg: e.toString());
    }
  }

}