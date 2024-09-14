import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase user

    Usere? _userFromfirebaseUser(User? user) {
      return user != null ? Usere(uid: user.uid) : null;
  }
  //auth change user strem
  Stream<Usere?> get user{
     // return _auth.authStateChanges().map((User? user) => _userFromfirebaseUser(user));
      return _auth.authStateChanges().map(_userFromfirebaseUser);
  }
//register
  Future registerWhith(String email,String password) async{
      try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = result.user;
        return _userFromfirebaseUser(user);
      }catch(e){
        print(e.toString());
        return null;
      }
  }

  //login
  Future LoginWhith(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromfirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromfirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}