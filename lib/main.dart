import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authBloc/auth_bloc.dart';
import 'package:flutter_app/blocs/authBloc/auth_event.dart';
import 'package:flutter_app/blocs/authBloc/auth_state.dart';
import 'package:flutter_app/homeScreen.dart';
import 'package:flutter_app/loginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(key: key,)
      // BlocProvider(
      //     create: (context) => AuthBloc()..add(AppStartedEvent()),
      //     child: const CheckAuthenticate(),
      //   )
    );
  }
}

class CheckAuthenticate extends StatelessWidget {
  const CheckAuthenticate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if(state is AuthInitialState){
             return const Center(child: CircularProgressIndicator(),);
          }
          else if(state is AuthenticatedState){
            return HomeParent(user: state.user,);
          }
          else if(state is UnAuthenticatedState){
            return const LoginParent();
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Icons.wb_auto,
        duration: 1500,
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: Colors.redAccent,
        nextScreen: BlocProvider(
          create: (context) => AuthBloc()..add(AppStartedEvent()),
          child: const CheckAuthenticate(),
        ),
    );
  }
}



