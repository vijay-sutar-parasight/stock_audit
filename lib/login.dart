import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/dashboard.dart';

class Login extends StatelessWidget{
var emailText = TextEditingController();
var passwordText = TextEditingController();
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
              ElevatedButton(onPressed: (){
              String uEmail = emailText.text.toString();
              String uPass = passwordText.text;
              print("Email: $uEmail, Password: $uPass");
              Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
              }, child: Text(
                'Login'
              ))
            ],
          ))),
    );
  }
  
}