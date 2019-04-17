import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/homePage.dart';

class signUp extends StatelessWidget {
  String _email, _password;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  var fkey = GlobalKey<FormState>();

  check(String email, String password, BuildContext context) async {
    try {
      _firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("${_firebaseUser.uid}");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (String value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+'
                        r')*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
                        r'\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regexp = RegExp(pattern);
                    if (value.isEmpty) {
                      return 'Email is needed';
                    } else if (!regexp.hasMatch(value)) {
                      return 'Invalid Email';
                    }
                  },
                  onSaved: (String value) {
                    _email = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                child: TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Password is needed';
                    } else if (value.length < 8) {
                      return 'Minimum length is 8';
                    }
                  },
                  onSaved: (String value) {
                    _password = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              RaisedButton(
                elevation: 2,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (fkey.currentState.validate()) {
                    check(_email, _password, context);
                  }
                },
              ),
              RaisedButton(
                elevation: 2,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    );
  }
}
