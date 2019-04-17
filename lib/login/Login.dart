import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/homePage.dart';
import 'package:whatsapp/login/signUp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  var fkey = GlobalKey<FormState>();
  final skey = GlobalKey<ScaffoldState>();
  String _email, _password;

  check(String email, String password, BuildContext context) async {
    if (fkey.currentState.validate()) {
      fkey.currentState.save();
      try {
        _firebaseUser = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print("${_firebaseUser.uid} is user id");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } catch (e) {
        print(e.message);
        skey.currentState
            .showSnackBar(SnackBar(content: Text('Some Error Occured')));
      }
    }
  }

  Future<FirebaseUser> getUser() async{
    return await _firebaseAuth.currentUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((_firebaseUser){
      if(_firebaseUser!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return HomePage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: skey,
      appBar: AppBar(
        title: Text("Login"),
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
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: TextFormField(
                obscureText: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Password is needed';
                  } else if (value.length < 8) {
                    return 'Minimum length of password is 8';
                  }
                },
                onSaved: (String value) {
                  _password = value;
                },
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            RaisedButton(
              elevation: 2,
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              color: Theme.of(context).primaryColor,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (fkey.currentState.validate()) {
                  check(_email, _password, context);
                  print(_email);
                  print(_password);
                }
              },
            ),
            RaisedButton(
              elevation: 2,
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              color: Theme.of(context).primaryColor,
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return signUp();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
