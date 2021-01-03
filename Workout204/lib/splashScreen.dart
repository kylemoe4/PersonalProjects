import 'package:flutter/material.dart';
import './LogIn.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() =>  _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
    void initState(){
    super.initState();
    Timer(Duration(seconds: 1),()=> Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            )); //placeholder to direct to next screen
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: Icon(
                            Icons.schedule, //placeholder until make icon
                            color: Colors.black26,
                            size: 50,

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:40.0),
                        ),
                        Text(
                          "Buildr",
                            style: TextStyle(
                            color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold),

                        )
                      ],
                    ),

                  ),
                ),
                Expanded(flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),

                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Text("Plan for gains",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),

                    ],
                  ),
                )
              ],

          )
        ],
      ),
    );
  }
}