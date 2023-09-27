import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const SUCCESS_MESSAGE=" You will be contacted by us very soon.";

// Api related
const apiBaseURL = "https://www.parasightdemo.com/castockaudit/api";
const databaseName = "stockaudit11.db";

Color mainColor = const Color(0xff8D2C8A);

// Asset Constants
const navBarLogoImage = "assets/images/home_images/sample.png";


void Notification(var message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColor,
      textColor: Colors.white,
      fontSize: 16.0
  );}