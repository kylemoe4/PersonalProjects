import 'package:Workout204/authentication.dart';
import 'package:Workout204/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pwreset.dart';
import 'signup.dart';
import 'authentication.dart';
import 'appOverlay.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pw = TextEditingController();
  final error = TextEditingController();
  String _errormsg = '';
  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/workout1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
                        decoration: InputDecoration(labelText: 'Email'),
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
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                        controller: pw,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
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
              padding: EdgeInsets.only(top: 0.0, left: 50.0, right: 50.0),
              child: RaisedButton(
                onPressed: () async {
                  _errormsg = '';
                  if (_formkey.currentState.validate() == true) {
                    dynamic result = await _auth.signIn(email.text, pw.text);
                    if (result != null) {
                      if (result == 'wrong-password') {
                        print('wrong password');
                        email.clear();
                        pw.clear();
                        setState(() {
                          _errormsg = 'Error: Wrong Password';
                        });
                      } else if (result == 'user-not-found') {
                        print('account doesn\'t exist');
                        email.clear();
                        pw.clear();
                        setState(() {
                          _errormsg =
                              'Error: Account with that email doesn\'t exist';
                        });
                      } else if (result == 'too-many-requests') {
                        print('too many requests');
                        email.clear();
                        pw.clear();
                        setState(() {
                          _errormsg = 'Error: too many requests';
                        });
                      } else {
                        print('log in success');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppOverlay()));
                      }
                    }
                  } else {
                    print('error in validation');
                  }
                },
                color: Colors.blue,
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
              child: Text(_errormsg, style: TextStyle(color: Colors.red)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 280.0),
              child: Row(
                children: <Widget>[
                  Text('Forgot '),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pw_reset_page(),
                        ),
                      );
                    },
                    child: Text(
                      'password?',
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
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 240.0),
              child: Row(
                children: <Widget>[
                  Text('First time? Sign Up '),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Here',
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
