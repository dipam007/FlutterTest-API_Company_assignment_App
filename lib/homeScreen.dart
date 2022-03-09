import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/homePageBloc/homePage_bloc.dart';
import 'package:flutter_app/blocs/homePageBloc/homePage_event.dart';
import 'package:flutter_app/blocs/homePageBloc/homePage_state.dart';
import 'package:flutter_app/data/model/api_result_model.dart';
import 'package:flutter_app/dataScreen.dart';
import 'package:flutter_app/loginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeParent extends StatelessWidget {

  User user;
  HomeParent({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: HomeScreen(user: user),
    );
  }
}

class HomeScreen extends StatelessWidget {

  User user;

  HomePageBloc homePageBloc;

  HomeScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Home Page"),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app_outlined),
              tooltip: 'Logout',
              onPressed: () async {
                homePageBloc.add(LogOutButtonPressedEvent());
              },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocListener<HomePageBloc, HomePageState>(
            listener: (context, state) {
              if(state is LogOutSuccessfulState){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginParent()));
              }
            },
            child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                    if(state is LogOutInitialState){
                      return const Center(child: Text("Wait..." ,style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),));
                    }else if(state is LogOutSuccessfulState){
                      return const SizedBox(height: 0, width: 0,);
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
                }
            ),
          ),
          Center(child: Text(user.email),),
          MaterialButton(
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DataParent()));
              },
              child: const Text("Data Page"),
          ),
        ],
      ),
    );
  }
}
