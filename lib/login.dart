import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_audit/dashboard.dart';
import 'package:stock_audit/splash_screen.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import 'db_handler.dart';

class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
var emailText = TextEditingController();

var passwordText = TextEditingController();

String lastSyncDate = "";
DBHelper? dbHelper;
bool isPasswordValid = false;
@override
void initState() {
  // TODO: implement initState
  super.initState();
  dbHelper = DBHelper();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: constants.mainColor,
      body:ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(image: AssetImage(constants.logo), width: 120, height: 120,),
                const Text("Stock Audit",style: TextStyle(color: Colors.white,fontSize: 25)),


                // SvgPicture.asset("assets/logo.svg",semanticsLabel: "Logo"),
                SizedBox(height:40),
              ],
            )
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.6,
              decoration: BoxDecoration(
                border: Border.all(
                  color: constants.mainColor
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white
              ),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(Icons.account_circle,
                          size: 140,
                            color: constants.mainColor
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20
                          ),
                          child: Text("Login",style: TextStyle(fontSize: 30,color: constants.mainColor),),
                        ),
                        TextField(
                          controller: emailText,
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: BorderSide(
                                      color: constants.mainColor,
                                    )
                                ),

                              // suffixText: 'Username exists',
                              // suffixIcon: IconButton(
                              //   icon: Icon(Icons.remove_red_eye, color: Colors.orange),
                              //   onPressed: (){
                              //
                              //   }
                              // ),
                              prefixIcon: Icon(Icons.email, color: constants.mainColor)
                            ),
                        ),
                        Container(height: 20),
                        TextField(
                          controller: passwordText,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: BorderSide(
                                      color: constants.mainColor,
                                    )
                                ),
                                prefixIcon: Icon(Icons.password, color: constants.mainColor)

                            )
                        ),
                        Container(height: 20),
                        ElevatedButton(onPressed: () async {
                        String uEmail = emailText.text.toString();
                        String uPass = passwordText.text;
                        print("Email: $uEmail, Password: $uPass");
                        var hashedPassword = "";
                        if(uEmail != '' && uPass != '') {
                          var user_info = dbHelper!.getAdminUser(uEmail);
                          user_info.then((value) =>
                          {
                            hashedPassword = value[0]['password'],
                            isPasswordValid = BCrypt.checkpw(uPass, hashedPassword),
                            passwordCheck(isPasswordValid)
                          });
                        }else{
                          passwordCheck(isPasswordValid);
                        }
                        }, child: Text(
                          'Login', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                        ),style: ElevatedButton.styleFrom(backgroundColor: constants.mainColor,),
                        )
                      ],
                    ),
                  ),
                ),

          ),
        ],
      ),
    );
  }

Future<void> passwordCheck(isPasswordValid) async {
  if (isPasswordValid) {
    // Password is valid
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
    constants.Notification("Logged In Successfully");
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Dashboard()), (
            route) => false);
  } else {
    // Password is invalid
    constants.Notification("Invalid username or password!");
  }
}
}