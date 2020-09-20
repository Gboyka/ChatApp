import 'package:flutter/material.dart';
import 'package:gupshup/helper/authenticate.dart';
import 'package:gupshup/helper/helperfunctions.dart';
import 'package:gupshup/views/chatroomsScreen.dart';
import 'package:gupshup/views/coversationScreen.dart';
import 'package:gupshup/views/searchScreen.dart';
import 'package:gupshup/views/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/signin.dart';
void main() {
 runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn=false;



  @override
  void initState() {
    getLoggedInState();
    // TODO: implement initState
    super.initState();
  }

  getLoggedInState()async{
   await HelperFunction.getUserLoggedInSharedPreference().then((value) {
     setState(() {
       loggedIn=value;
     });
   });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title:'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: Firebase.initializeApp(),
            builder:(context,snapshot) {
              if(snapshot.hasError) {
                return Text('Connection Problem');
              }
              if(snapshot.connectionState==ConnectionState.done){
                 return loggedIn!=null?loggedIn? ChatRoom():Authenticate():Container(
                  child: Center(
                    child: Authenticate(),
                  ),
                );
              //  return ConversationScreen('dogaa_gautam');
              }
              return Center(child:CircularProgressIndicator());
            }
        )
    );
  }
}

