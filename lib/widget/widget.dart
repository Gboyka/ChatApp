import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
  title:Text('Gupp Shupp ')

  );
}

InputDecoration textFieldInputDecoration(String hintText)
{
return InputDecoration(
    hintText: hintText,
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color:Colors.orangeAccent)
          ),
      enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue)
    )

);

}

TextStyle simpleTextStyle(double size){
  return TextStyle(
    color: Colors.blueAccent,
    fontSize: size
  );
}



