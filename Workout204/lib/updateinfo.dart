import 'package:Workout204/infopage.dart';
import 'package:flutter/material.dart';
import './workoutSchedule.dart';
import 'authentication.dart';
import 'package:Workout204/authentication.dart';
import 'package:Workout204/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pwreset.dart';
import 'signup.dart';
import 'appOverlay.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'db.dart';

class InfoupdatePage extends StatefulWidget {
  @override
  _InfoupdateScreenState createState() => _InfoupdateScreenState();
}

class _InfoupdateScreenState extends State<InfoupdatePage> {
  final _formkey = GlobalKey<FormState>();
  final height = TextEditingController();
  final weight = TextEditingController();
  final name = TextEditingController();
  final error = TextEditingController();
  String _errormsg = '';
  final Authentication __auth = Authentication();
  final FirebaseAuth _auth =FirebaseAuth.instance;


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
                      child: Text("Email: "+ _auth.currentUser.email)
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
                        controller: name,
                        decoration: InputDecoration(labelText: 'name'),
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
                            return 'Enter your height';
                          } else if (!isNumeric(val)) {
                            return 'Only enter numeric value';
                          }
                          return null;
                        },
                        controller: height,
                        decoration: InputDecoration(labelText: 'height (cm) '),
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
                            return 'Enter your weight';
                          } else if (!isNumeric(val)) {
                            return 'Only enter numeric value';
                          }
                          return null;
                        },
                        controller: weight,
                        decoration: InputDecoration(labelText: 'weight (kg)'),
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
                  _errormsg = '';
                  if (_formkey.currentState.validate() == true) {
                    final User user = _auth.currentUser;
                    final String uid = user.uid;
                    final db = DBService(uid: uid);
                    db.setheight(height.text);
                    db.setweight(weight.text);
                    db.setname(name.text);
                    Navigator.of(context).pop();
                  } else {
                    print('error in validation');
                  }
                },
                color: Colors.blue,
                child: Text(
                  'submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.only(left: 50.0, bottom: 10.0),
              child: Text(
                _errormsg,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
