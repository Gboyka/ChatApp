
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gupshup/helper/helperfunctions.dart';
import 'package:gupshup/services/auth.dart';
import 'package:gupshup/services/database.dart';
import '../widget/widget.dart';
import 'chatroomsScreen.dart';

class SignIn extends StatefulWidget{
  final Function toggle;
  SignIn(this.toggle);


  @override
  _SignInState createState() => _SignInState();

}

class _SignInState extends State<SignIn>{


  TextEditingController emailFieldController =new TextEditingController();
  TextEditingController passwordFieldController =new TextEditingController();
  final formKey=GlobalKey<FormState>();
  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();
  bool isLoading=false;
  QuerySnapshot snapshotUserInfo;


  signIn() async{
    if (formKey.currentState.validate()) {

      setState(() {
        isLoading = true;
      });

      await authMethods.signUpWithEmailAndPassword(
          emailFieldController.text, passwordFieldController.text).then((
          value) async{
        if (value != null) {
          QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserByEmail(emailFieldController.text);

          HelperFunction.saveUserLoggedInSharedPreference(true);
          HelperFunction.saveUserNameSharedPreference(
              snapshotUserInfo.docs[0].data()['name']);
          HelperFunction.saveUserEmailSharedPreference(
              snapshotUserInfo.docs[0].data()['email']);


          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
        else{
          setState(() {
            isLoading=false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:Container(
        alignment: Alignment.bottomCenter,
        child:Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal:24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Form(
               key:formKey,
               child: Column(
                  children: [
                     TextFormField(
    
                   controller: emailFieldController,
    
                     style:simpleTextStyle(16.0),
                      validator: (val){
                     return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9."
                           r"!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\."
                           r"[a-zA-Z]+").hasMatch(val)?null:"invalid email";
                         },
    
                   decoration: textFieldInputDecoration('Registered email')
    
                ),
    
                TextFormField(
    
                  controller: passwordFieldController,
                    validator: (val){
                      return val.length>6?null:"too short";
                    },
                    obscureText: true,
                  style:simpleTextStyle(16.0),
    
                  decoration: textFieldInputDecoration('Password')
    
                ),
    
                SizedBox(height: 18,),
    
                  Container(
    
                   alignment: Alignment.centerRight,
    
                      child:Container(
    
                    padding: EdgeInsets.symmetric(horizontal:16,vertical: 8),
    
                    child:Text('Forgot Password ?',style:simpleTextStyle(14.0))
    
                  )
    
                  ),
    
                  SizedBox(height: 20,),
    
                Row(
    
                  children:<Widget>[
    
                  SizedBox(width:40 ,),
    
                    RaisedButton(
    
                    padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 15.0),
    
                    child:Text('Sign In',style:simpleTextStyle(20.0)),
    
                    color:Colors.white,
    
                    elevation: 8.0,
    
                    splashColor: Colors.lightGreen,
    
                    focusColor: Colors.red,
    
    
    
                    shape: RoundedRectangleBorder(
    
                      borderRadius: BorderRadius.circular(15.0),
    
    
    
                    ),
    
                    onPressed: () {
    
                     signIn();
    
                    },
    
                  ),
    
                  SizedBox(width: 15,),
    
                  RaisedButton(
    
                    padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 25.0),
    
                    child:Image.asset('./assets/images/google.png',height: 25,width: 25,),
    
                    color:Colors.white,
    
                    elevation: 8.0,
    
                    splashColor: Colors.lightGreen,
    
                    focusColor: Colors.red,
    
    
    
                    shape: CircleBorder(),
    
                    onPressed: () {
    
                      debugPrint("pressed SingIn");
    
                    },
    
                  ),
    
                ]
    
        ),
    
                  SizedBox(height: 22,),
    
                  Row(
    
                    mainAxisAlignment: MainAxisAlignment.center,
    
                      children: <Widget>[
    
                    Text('New to Gupp Shupp ?  ',style:simpleTextStyle(14.0)),
    
                        GestureDetector(
    
                          onTap: (){
    
                            widget.toggle();
    
                          },
    
                          child: Container(
    
                            child: Text('Register Here',style: TextStyle(
    
                              color: Colors.green,
    
                              fontSize: 16,
    
                              decoration: TextDecoration.underline
    
                            ),),
    
                          ),
    
                        )
    
    
    
    
    
    
    
                  ]
    
                  ),
    
                  SizedBox(height: 25,),   ],
  ),
             ),
]
        ),
      )
      )
    );


}
  }