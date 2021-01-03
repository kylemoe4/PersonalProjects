
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'client.dart';
import 'db.dart';

class Authentication {

//create an instance to communicate with firebaseAuth.
//_ means private 
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //create client object
  Client _firebaseClient(User user){
    //if user isn't null return a client object with uid.
    return user !=null ? Client(uid: user.uid): null;
  }

  //Auth change user stream
  Stream <Client> get user {
    return _firebaseAuth.authStateChanges()
    .map(_firebaseClient);
  }
  

  //sign in with email/pw
  Future signIn(String email, String password) async{
    try{
      UserCredential result= await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User newuser = result.user;
      return _firebaseClient(newuser);
    }catch(e){
      print(e.code);
      return e.code;
    }
  }

  // register with email/pw
  Future register (String email, String password, String name) async{
    try{
      UserCredential result= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User newuser = result.user;
      await DBService(uid: newuser.uid).updateUserData(name);
      return _firebaseClient(newuser);
    }catch(e){
      print(e.details);
      return null;
    }
  }

  //pw recovery
  Future pwreset (String email) async{
    String _errormsg='';
       await _firebaseAuth.sendPasswordResetEmail(email: email)
       .then((value) => _errormsg=null)
       .catchError((onError){
           _errormsg=onError.code;
           print(_errormsg);
           return _errormsg;
       });
    return _errormsg;
  }

  
  //sign out

  
/*
  Future <String> signIn({String email, String pw}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pw);
      return "Signed In";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  Future <String> signUp({String email, String name, String pw}) async{
    try{
      UserCredential result= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pw);
      return "Signed Up";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  */
  
}