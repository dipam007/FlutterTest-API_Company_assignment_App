import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  FirebaseAuth firebaseAuth;

  UserRepository() {
    firebaseAuth = FirebaseAuth.instance;
  }
  
  Future<User> createUser(String email, String password) async{
      try{
        var result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('email', email);
        return result.user;
      }on PlatformException catch(e){
          throw Exception(e.toString());
      }
  }

  Future<User> signInUser(String email, String password) async{
    try{
      var result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('email', email);
      return result.user;
    }on PlatformException catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    await firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userEmail = sharedPreferences.getString('email');
    return userEmail != null;
    // var currentUser = await firebaseAuth.currentUser;
    // return currentUser != null;
  }

  Future<User> getCurrentUser() async{
    return firebaseAuth.currentUser;
  }

}










