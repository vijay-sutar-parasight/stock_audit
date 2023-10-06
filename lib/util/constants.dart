import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const SUCCESS_MESSAGE=" You will be contacted by us very soon.";

// Api related
const apiBaseURL = "https://www.parasightdemo.com/castockaudit/api";
const databaseName = "stockaudit11.db";

Color mainColor = const Color(0xff8D2C8A);
const brandIcon = "assets/icons/brand.png";
const formatIcon = "assets/icons/format.png";
const variantIcon = "assets/icons/variant.png";
const descriptionIcon = "assets/icons/description.png";
const warehouseIcon = "assets/icons/warehouse.png";
const datasyncIcon = "assets/icons/datasync.png";
const auditIcon = "assets/icons/audit.png";
const logo = "assets/logo.png";

const double bodyPadding = 10;
const double buttonWidth = 200;
const double buttonHeight = 60;

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