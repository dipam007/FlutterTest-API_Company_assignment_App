import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/registerBloc/register_bloc.dart';
import 'package:flutter_app/blocs/registerBloc/register_event.dart';
import 'package:flutter_app/blocs/registerBloc/register_state.dart';
import 'package:flutter_app/homeScreen.dart';
import 'package:flutter_app/loginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterParent extends StatelessWidget {
  const RegisterParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatelessWidget {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  RegisterBloc registerBloc;

  RegisterScreen({Key key}) : super(key: key);

  Widget regFailure(String msg){
    return Text(msg, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),);
  }

  Widget regLoading(){
    return const Center(child: CircularProgressIndicator(),);
  }

  @override
  Widget build(BuildContext context) {
    registerBloc = BlocProvider.of<RegisterBloc>(context);

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
              child: Text("Sign up",
                style: TextStyle(
                    color: Colors.limeAccent.withOpacity(0.8),
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
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if(state is RegisterSuccessfulState){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeParent(user: state.user,)));
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      if(state is RegisterInitialState){
                        return const Center(child: Text("Wait..." ,style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),));
                      }else if(state is RegisterLoadingState){
                        return regLoading();
                      }else if(state is RegisterSuccessfulState){
                         return const SizedBox(height: 0, width: 0,);
                      }else if(state is RegisterFailureState){
                         return regFailure(state.msg);
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08, right: MediaQuery.of(context).size.width*0.05, left: MediaQuery.of(context).size.width*0.05, ),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Enter Your Name",
                        labelStyle: const TextStyle(color: Colors.limeAccent, fontWeight: FontWeight.bold),
                        prefixIcon: const Icon(Icons.account_circle, color: Colors.limeAccent,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.limeAccent,),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        labelStyle: const TextStyle(color: Colors.limeAccent, fontWeight: FontWeight.bold),
                        prefixIcon: const Icon(Icons.email, color: Colors.limeAccent,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.limeAccent,),
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
                        labelStyle: const TextStyle(color: Colors.limeAccent, fontWeight: FontWeight.bold),
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.limeAccent,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.limeAccent,),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.width*0.05, left: MediaQuery.of(context).size.width*0.05, ),
                    child: MaterialButton(
                        elevation: 4,
                        height: 50,
                        minWidth: 150,
                        child: const Text("Sign up", style: TextStyle(color: Colors.blueGrey, letterSpacing: 1.0, wordSpacing: 1.0, fontWeight: FontWeight.bold, fontSize: 22),),
                        color: Colors.limeAccent,
                        onPressed: () async {
                          registerBloc.add(SignUpButtonPressedEvent(email: _emailController.text, password: _passController.text));
                        }
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, bottom: MediaQuery.of(context).size.height * 0.02),
                        color: Colors.transparent,
                        child: const Text("Do you have an Acoount? ", style: TextStyle(color: Colors.black54),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, bottom: MediaQuery.of(context).size.height * 0.02),
                        color: Colors.transparent,
                        child: GestureDetector(
                          child: const Text("Login now", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginParent()));
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
