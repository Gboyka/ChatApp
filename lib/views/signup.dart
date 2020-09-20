
import 'package:flutter/material.dart';
import 'package:gupshup/helper/helperfunctions.dart';
import 'package:gupshup/services/auth.dart';
import 'package:gupshup/services/database.dart';
import '../widget/widget.dart';
import 'chatroomsScreen.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget{
  final Function toggle;
  SignUp(this.toggle);

  @override
  State<StatefulWidget> createState()=>_SignUpState();

}

class _SignUpState  extends State<SignUp>{
  bool isLoading=false;
  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();
  //HelperFunction helperFunction=new HelperFunction();

  TextEditingController userNameFieldController =new TextEditingController();
  TextEditingController emailFieldController =new TextEditingController();
  TextEditingController passwordFieldController =new TextEditingController();
  //TextEditingController confirmPasswordFieldController =new TextEditingController();
  final formKey =GlobalKey<FormState>();


  signUp() {
    if (formKey.currentState.validate()) {
      Map<String,String> userInfoMap={
        'name':userNameFieldController.text,
        'email':emailFieldController.text
      };

      HelperFunction.saveUserEmailSharedPreference(emailFieldController.text);
      HelperFunction.saveUserNameSharedPreference(userNameFieldController.text);

      setState(() {
        isLoading=true;
      });
      authMethods.signUpWithEmailAndPassword
        (emailFieldController.text,passwordFieldController.text);

      databaseMethods.uploadUserInfo(userInfoMap);
      HelperFunction.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>ChatRoom()
        ));
    
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading?Container(
        child:Center(
        child:CircularProgressIndicator()
      )):Container(
        alignment: Alignment.bottomCenter,
        child:Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal:24),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key:formKey,
                  child: Column(
                    children:<Widget>[
                  TextFormField(
                    validator: (val){
                      return val.isEmpty || val.length<4?"enter valid username":null;
                    },
                    controller: userNameFieldController,
                      style:simpleTextStyle(16.0),
                      decoration: textFieldInputDecoration('Username')
                  ),
                  TextFormField(
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9."
                        r"!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\."
                        r"[a-zA-Z]+").hasMatch(val)?null:"invalid email";
                      },
                    controller: emailFieldController,
                      style:simpleTextStyle(16.0),
                      decoration: textFieldInputDecoration('E-mail')
                  ),
                  TextFormField(
                      validator: (val){
                        return val.length>6?null:"too short";
                      },
                      obscureText: true,
                    controller: passwordFieldController,
                      style:simpleTextStyle(16.0),
                      decoration: textFieldInputDecoration('Password')
                  ),
                  
             /*   TextField(
                    controller: confirmPasswordFieldController,
                      style:simpleTextStyle(16.0),
                      decoration: textFieldInputDecoration('Confirm Password')
                  ),*/
             ],
      ),
                ),

                SizedBox(height: 20,),
                Row(
                    children:<Widget>[
                      SizedBox(width:40 ,),
                      RaisedButton(

                        padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 15.0),
                        child:Text('Sign Up',style:simpleTextStyle(20.0)),
                        color:Colors.white,
                        elevation: 8.0,
                        splashColor: Colors.lightGreen,
                        focusColor: Colors.red,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),

                        ),
                        onPressed: () {
                            signUp();
                        },
                      ),
                      SizedBox(width: 15,),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 25.0),
                        child:Image.asset('./assets/images/google.png',height: 30,width: 30,),
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
                      Text('Already Registered ?  ',style:simpleTextStyle(14.0)),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          child: Text('Log In now !',style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              decoration: TextDecoration.underline
                          ),),
                        ),
                      )




                    ]
                ),
                SizedBox(height: 25,),   ]
          ),
        )
    ),
    );

  }

}



