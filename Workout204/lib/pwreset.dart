import 'package:flutter/material.dart';
import 'LogIn.dart';
import 'authentication.dart';
import 'package:string_validator/string_validator.dart';

// ignore: camel_case_types
class pw_reset_page extends StatefulWidget {
  @override
  _pw_reset_page createState() => _pw_reset_page();
}

// ignore: camel_case_types
class _pw_reset_page extends State<pw_reset_page> {
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final Authentication _auth = Authentication();
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
                  IconButton(icon: Icon(Icons.person), onPressed: () {}),
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
              padding: EdgeInsets.only(top: 0.0, left: 50.0, right: 50.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    dynamic result = await _auth.pwreset(email.text);
                    print(result);
                    if (result != null) {
                      if (result == 'user-not-found') {
                        email.clear();
                        setState(() {
                          error = 'user with email not found';
                        });
                      }
                    } else {
                      AlertDialog alert = AlertDialog(
                        title: Text('Email has been sent'),
                        content: Text('Password reset email has been sent to ' +
                            email.text),
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
                },
                color: Colors.blue,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}