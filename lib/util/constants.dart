import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const SUCCESS_MESSAGE=" You will be contacted by us very soon.";

// Api related
const apiBaseURL = "https://www.parasightdemo.com/castockaudit/api";
const databaseName = "stockaudit6.db";

const userLoginApi = "login";
const userSignupApi = "signup";

// Shared Preference keys
const kDeviceName = "device_name";
const kDeviceUDID = "device_id";

// Asset Constants
const navBarLogoImage = "assets/images/home_images/sample.png";


void Notification(var message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.lightBlue,
      textColor: Colors.white,
      fontSize: 16.0
  );}