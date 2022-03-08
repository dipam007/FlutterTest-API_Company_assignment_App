import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/loginBloc/login_bloc.dart';
import 'package:flutter_app/blocs/loginBloc/login_event.dart';
import 'package:flutter_app/blocs/loginBloc/login_state.dart';
import 'package:flutter_app/homeScreen.dart';
import 'package:flutter_app/registerScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginParent extends StatelessWidget {
  const LoginParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  LoginBloc loginBloc;

  LoginScreen({Key key}) : super(key: key);

  Widget loginFailure(String msg){
    return Text(msg, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),);
  }

  Widget loginLoading(){
    return const Center(child: CircularProgressIndicator(),);
  }

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/appBackImg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 120,
          title: Container(
              margin: const EdgeInsets.only(top: 40),
              child: Text("Sign in",
                style: TextStyle(
                          color: Colors.tealAccent.withOpacity(0.8),
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          shadows: const <Shadow>[
                              Shadow(
                                  offset: Offset(10.0, 10.0),
                                  blurRadius: 3.0,
                                  color: Color.fromRGBO(255, 0, 0, 0)
                              ),
                            Shadow(
                                  offset: Offset(10.0, 10.0),
                                  blurRadius: 8.0,
                                  color: Color.fromRGBO(125, 0, 0, 255)
                              ),
                          ]
                      ),
              )
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if(state is LoginSuccessfulState){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeParent(user: state.user,)));
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if(state is LoginInitialState){
                        return const Center(child: Text("Wait..." ,style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),));
                      }else if(state is LoginLoadingState){
                        return loginLoading();
                      }else if(state is LoginSuccessfulState){
                        return const SizedBox(height: 0, width: 0,);
                      }else if(state is LoginFailureState){
                        return loginFailure(state.msg);
                      }
                      else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, right: MediaQuery.of(context).size.width*0.05, left: MediaQuery.of(context).size.width*0.05, ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        labelStyle: const TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold),
                        prefixIcon: const Icon(Icons.email, color: Colors.tealAccent,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.tealAccent,),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, right: MediaQuery.of(context).size.width*0.05, left: MediaQuery.of(context).size.width*0.05, ),
                    child: TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        labelStyle: const TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold),
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.tealAccent,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.tealAccent,),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 8, right: MediaQuery.of(context).size.width*0.075, ),
                    color: Colors.transparent,
                    child: GestureDetector(
                      child: const Text("Forgot Password?", style:TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold, fontSize: 14, decoration: TextDecoration.underline),),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterParent()));
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.02, right: MediaQuery.of(context).size.width*0.05, left: MediaQuery.of(context).size.width*0.05, ),
                    child: MaterialButton(
                        elevation: 10,
                        height: 50,
                        minWidth: 150,
                        child: const Text("Sign in", style: TextStyle(color: Colors.blueGrey, letterSpacing: 1.0, wordSpacing: 1.0, fontWeight: FontWeight.bold, fontSize: 22),),
                        color: Colors.tealAccent,
                        onPressed: () async{
                            loginBloc.add(LoginButtonPressedEvent(email: _emailController.text, password: _passController.text));
                        }
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, left: MediaQuery.of(context).size.width*0.05, ),
                        color: Colors.transparent,
                        child: const Text("Don't have an Acoount? ", style: TextStyle(color: Colors.black54),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, right: MediaQuery.of(context).size.width*0.05, ),
                        color: Colors.transparent,
                        child: GestureDetector(
                                child: const Text("Register now", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterParent()));
                                },
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
