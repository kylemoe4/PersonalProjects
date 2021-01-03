import 'package:Workout204/LogIn.dart';
import 'package:flutter/material.dart';
import './appOverlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage({this.toggleView});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPage> {
  final Authentication _auth = Authentication();
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final name = TextEditingController();
  final pw = TextEditingController();
  final pwc = TextEditingController();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/run.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.mail), onPressed: () {}),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4, right: 20),
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter an email';
                          } else if (!isEmail(val)) {
                            return 'Not a valid email';
                          }
                          return null;
                        },
                        controller: email,
                        decoration: InputDecoration(hintText: 'Email'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.person), onPressed: () {}),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4, right: 20),
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter your name';
                          } else if (!isAlpha(val)) {
                            return 'Invalid name';
                          }
                          return null;
                        },
                        controller: name,
                        decoration: InputDecoration(hintText: 'Name'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.lock), onPressed: () {}),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4, right: 20),
                      child: TextFormField(
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter a pw';
                          } else if (val.length < 6) {
                            return 'password must be longer than 6 characters';
                          }
                          return null;
                        },
                        controller: pw,
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.lock), onPressed: () {}),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4, right: 20),
                      child: TextFormField(
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Confirm password';
                          } else if (!equals(val, pw.text)) {
                            return 'passwords must match';
                          }
                          return null;
                        },
                        controller: pwc,
                        decoration:
                            InputDecoration(hintText: 'Confirm Password'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: RaisedButton(
                onPressed: () async {
                  error = '';
                  if (_formkey.currentState.validate()) {
                    dynamic result =
                        await _auth.register(email.text, pw.text, name.text);
                    if (result != null) {
                      print('registraion failed');
                      if (result == 'email-already-in-use') {
                        email.clear();
                        pw.clear();
                        name.clear();
                        pwc.clear();
                        setState(() {
                          error = 'emails already in use';
                        });
                      } else {
                        AlertDialog alert = AlertDialog(
                          title: Text('Registration Success!'),
                          content: Text('Registration Success!'),
                          actions: [
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    }
                  }
                },
                color: Colors.blue,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
              child: Text(error, style: TextStyle(color: Colors.red)),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 200.0),
              child: Row(
                children: <Widget>[
                  Text('Already have an account?'),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}