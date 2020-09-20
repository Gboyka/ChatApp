import 'package:flutter/material.dart';
import 'package:gupshup/views/chatroomsScreen.dart';
import 'package:gupshup/views/signin.dart';
import 'package:gupshup/views/signup.dart';


class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState()=> _AuthenticateState();
  }



class _AuthenticateState extends State<Authenticate>{

  bool showSignIn=true;

  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;

    });
  }


  @override
Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView);
    }
    else{
      return SignUp(toggleView);
    }


  }


}