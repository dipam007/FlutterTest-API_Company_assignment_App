import 'package:flutter_app/blocs/homePageBloc/homePage_event.dart';
import 'package:flutter_app/blocs/homePageBloc/homePage_state.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState>{

  UserRepository userRepository;

  HomePageBloc(){
    userRepository = UserRepository();
  }

  @override
  HomePageState get initialState => LogOutInitialState();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async*{
     try{
       if(event is LogOutButtonPressedEvent){
         await userRepository.signOut();
         yield LogOutSuccessfulState();
       }
     }catch(e){
       throw Exception(e.toString());
     }
  }
}