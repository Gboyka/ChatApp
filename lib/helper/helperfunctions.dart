
import 'package:gupshup/services/auth.dart';
import 'package:gupshup/services/database.dart';
import 'package:gupshup/views/coversationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class HelperFunction{

  static String sharePreferenceUserLoggedInKey="ISLOGGEDIN";

  static String sharePreferenceUserNameKey="USERNAMEKEY";

  static String sharePreferenceUserEmailKey="ISLOGGEDIN";

  DatabaseMethods databaseMethods=new DatabaseMethods();

//setters

static Future<void> saveUserLoggedInSharedPreference(bool isLoggedIn) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();

      preferences.setBool(sharePreferenceUserLoggedInKey,isLoggedIn);


  }


  static Future<void> saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();

      preferences.setString(sharePreferenceUserNameKey,userName);


  }
  static Future<void> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();

      preferences.setString(sharePreferenceUserEmailKey,userEmail);


  }

  //getters


  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();

    return  preferences.getString(sharePreferenceUserNameKey);

  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();

    return  preferences.getString(sharePreferenceUserEmailKey);


  }


  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();

    return  preferences.getBool(sharePreferenceUserLoggedInKey);


  }








}