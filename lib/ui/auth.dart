import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

enum AuthStatus{
  notSignedIn,
  signedIn
}

class Auth{

  Future<dynamic> userStatus() async {
    FirebaseUser user =  await FirebaseAuth.instance.currentUser();
    // print("current user under listing ${user.displayName}");
    // print("current user under listing ${user.uid}");
    if(user == null){
      return null;  
    }else{
      return user;
    }
    
  }

}
