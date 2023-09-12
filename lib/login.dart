import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: Text("Login", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body:Center(child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(Icons.account_circle,
                size: 140,
                  color: Colors.orange
                ),
              ),
              TextField(
                controller: emailText,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 2
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2
                      )
                    ),
                    // suffixText: 'Username exists',
                    // suffixIcon: IconButton(
                    //   icon: Icon(Icons.remove_red_eye, color: Colors.orange),
                    //   onPressed: (){
                    //
                    //   }
                    // ),
                    prefixIcon: Icon(Icons.email, color: Colors.orange)
                  ),
              ),
              Container(height: 11),
              TextField(
                controller: passwordText,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.password, color: Colors.orange)

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
              // user.then((value) => {
              //   lastSyncDate = value,
              //   dbHelper!.fetchAllData(lastSyncDate)
              // }
              // );
              // String storedHashedPassword = hashedPassword; // Replace with the actual stored hash
              // String inputPassword = uPass; // Replace with the user's input password

              // bool isPasswordValid = Bcrypt.compare(inputPassword, storedHashedPassword);
              //final String hashed = BCrypt.hashpw("password", BCrypt.gensalt());
              // $2a$10$r6huirn1laq6UXBVu6ga9.sHca6sr6tQl3Tiq9LB6/6LMpR37XEGu


              // true


              }, child: Text(
                'Login'
              ))
            ],
          ))),
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