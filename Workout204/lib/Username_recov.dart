import 'package:flutter/material.dart';
import 'LogIn.dart';

// ignore: camel_case_types
class Username_Recov_Page extends StatefulWidget {
  @override
  _Username_Recov_ScreenState createState() => _Username_Recov_ScreenState();
}

// ignore: camel_case_types
class _Username_Recov_ScreenState extends State<Username_Recov_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
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
                    child: TextField(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              color: Colors.blue,
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
