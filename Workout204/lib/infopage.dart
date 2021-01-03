import 'package:Workout204/updateinfo.dart';
import 'package:flutter/material.dart';
import './workoutSchedule.dart';
import './updateinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'db.dart';
import 'LogIn.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoPage> {
  static const days = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"];
  String email='';
  String name='';
  String height='';
  String weight='';
  double bmi=0.0;

  List<String> dropdownNames = new List<String>();
  List<DropdownMenuItem<String>> dropdownItems = new List<
      DropdownMenuItem<String>>();
  String dropdownValue = "Delete Workout";

  final FirebaseAuth _auth =FirebaseAuth.instance;
  void initState(){
    final User user = _auth.currentUser;
    final String uid = user.uid;
    final db = DBService(uid: uid);
    email=user.email;
    getdata(db).then((value){
      setState(() {
      });
    });
    db.getSavedWorkoutNames().then((value) {
      setState(() {
        dropdownNames = [];
        dropdownItems = [];
        for (int i = 0; i < value.length; i++) {
          if (!days.contains(value[i])) {
            dropdownNames.add(value[i]);
            dropdownItems.add(new DropdownMenuItem(
              child: Text(value[i],style: TextStyle(color: Colors.white,),),
              value: value[i],
            ));
          }
        }
      });
    });
  }

  Future getSaved() async {
    final User user = _auth.currentUser;
    final String uid = user.uid;
    final db = DBService(uid: uid);
    return await db.getSavedWorkoutNames();
  }

  getdata(DBService db) async{
    name = await db.getName();
    height = await db.getHeight();
    weight = await db.getWeight();
    
    try{
      var w = double.parse(weight);
      var h = double.parse(height);
      bmi = (w/(h*h))*10000;
    }catch (e) {
    }
    
    print("name: "+ name);
    print("height: "+ height);
    print("weight: "+ weight);
    print(bmi);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                IconButton(icon: Icon(Icons.mail), onPressed: () {}),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 20),
                    child: Text('email: '+ email),
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
                    child: Text('name: '+ name),
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
                    child: Text('height: '+ height + " cm"),
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
                    child: Text('weight: '+ weight + " kg"),
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
                    child: Text('Estimated BMI: '+ bmi.toStringAsFixed(2) + " %"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0, left: 50.0, right: 50.0),
            child: RaisedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoupdatePage()),
                );
                final User user = _auth.currentUser;
                final String uid = user.uid;
                final db = DBService(uid: uid);
                getdata(db).then((value){
                  setState(() {
                  });
                });
              },
              color: Colors.blue,
              child: Text(
                'Update Info',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0, left: 50.0, right: 50.0),
            child: RaisedButton(
              onPressed: () async {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage()),
                        );
                  
              },
              color: Colors.blue,
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            margin: EdgeInsets.all(8),
            height: 40,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Center(
              child: DropdownButton<String>(
                dropdownColor: Colors.red,
                icon: Icon(                // Add this
                  Icons.arrow_drop_down,  // Add this
                  color: Colors.white,   // Add this
                ),
                hint: Text(
                  "Delete Workout",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  getSaved().then((value) {
                    setState(() {
                      dropdownNames = [];
                      dropdownItems = [];
                      for (int i = 0; i < value.length; i++) {
                        if (!days.contains(value[i])) {
                          dropdownNames.add(value[i]);
                          dropdownItems.add(new DropdownMenuItem(
                            child: Text(value[i],style: TextStyle(color: Colors.white,),),
                            value: value[i],
                          ));
                        }
                      }
                    });
                  });
                },
                onChanged: (String newValue) async {
                  final User user = _auth.currentUser;
                  final String uid = user.uid;
                  final bool confirm = await _confirmDelete(context,newValue);
                  if (confirm) {
                    setState(() {
                      final db = DBService(uid: uid);
                      db.deleteWorkout(newValue);
                      dropdownNames.removeWhere((item) => item == newValue);
                      dropdownItems.removeWhere((item) => item.value == newValue);
                    });
                    print("deleted : " + newValue);
                  }
                  
                },
                items: dropdownItems,
              ),
            ),
          ),
          
        ],
      ),
    );
  }


  Future _confirmDelete(BuildContext context, String toDelete) async {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Workout: ' + toDelete),
          actions: [
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}