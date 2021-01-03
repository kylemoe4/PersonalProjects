import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './workoutSet.dart';
import './addSet.dart';
import './db.dart';

// Alright, the code in this one is pretty dense so I'll try to provide enough
// annotations so you get the general functionality

// Initialize the Schedule State
// page encodes what day this schedule is on
class Schedule extends StatefulWidget {
  final int page;

  const Schedule({Key key, this.page}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScheduleState();
  }
}

// Creates the actual stateful class
class _ScheduleState extends State<Schedule>
    with AutomaticKeepAliveClientMixin<Schedule> {
  // the 'with AutomaticKeep...' just means that code is persistant when changing tabs
  List<WorkoutSet> workout = new List<WorkoutSet>(); // Holds all workout data
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // this allows is to access the user credentials

  static const days = [
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday"
  ];
  List<String> dropdownNames = new List<String>();
  List<DropdownMenuItem<String>> dropdownItems = new List<
      DropdownMenuItem<
          String>>(); // Saved workouts access through load workout button
  String dropdownValue = "Load Workout";

  // initialization populates the workout with day of week's workout as well as
  // populating the dropdown menu with saved workouts
  @override
  void initState() {
    super.initState();
    if (widget.page != null) {
      getSet(days[widget.page]).then((value) {
        setState(() {
          workout = value;
        });
      });
    }
    getSaved().then((value) {
      setState(() {
        dropdownNames = [];
        dropdownItems = [];
        for (int i = 0; i < value.length; i++) {
          dropdownNames.add(value[i]);
          dropdownItems.add(new DropdownMenuItem(
            child: Text(value[i]),
            value: value[i],
          ));
        }
      });
    });
  }

  // this just returns the saved workout for a specific name
  Future getSet(String name) async {
    final User user = _auth.currentUser;
    final String uid = user.uid;
    final db = DBService(uid: uid);
    return await db.getWorkoutData(name);
  }

  // This returns a list of saved workout names
  Future getSaved() async {
    final User user = _auth.currentUser;
    final String uid = user.uid;
    final db = DBService(uid: uid);
    return await db.getSavedWorkoutNames();
  }

  // This validates a new set and adds it to the list
  void _validateNewSet(WorkoutSet newSet) {
    if (newSet != null) {
      setState(() {
        workout.add(newSet);
        final User user = _auth.currentUser;
        final String uid = user.uid;
        final db = DBService(uid: uid);
        db.updateUserWorkouts(workout, days[widget.page]);
        if (!dropdownNames.contains(days[widget.page])) {
          dropdownItems.add(new DropdownMenuItem(
            child: Text(days[widget.page]),
            value: days[widget.page],
          ));
          dropdownNames.add(days[widget.page]);
        }
      });
    }
  }

  // This is used for the Save Workout button to save a workout
  Future _asyncInputDialog(BuildContext context, bool save) async {
    String workoutName = save ? days[widget.page] : "";
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter workout name'),
          content: new Row(
            children: [
              new Expanded(
                child: new TextFormField(
                  //initialValue: workoutName,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Workout Name', hintText: 'eg. Biceps1'),
                  onChanged: (value) {
                    if (value == '')
                      workoutName = days[widget.page];
                    else
                      workoutName = value;
                  },
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(workoutName);
              },
            ),
          ],
        );
      },
    );
  }

  // The following code builds the schedule from the starting point of an
  // empty list and adds elements as necessary. the floatingActionButton
  // encodes how new sets are added to the list
  Widget _myScheduleView() {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                /// Button to Save a workout
                color: Colors.blue[100],
                onPressed: () async {
                  if (workout.length == 0) {
                    print(0);
                    return null;
                  } else {
                    final User user = _auth.currentUser;
                    final String uid = user.uid;
                    final String workoutName =
                        await _asyncInputDialog(context, true);
                    print(workoutName);
                    print(uid);
                    if (workoutName != null) {
                      DBService(uid: uid)
                          .updateUserWorkouts(workout, workoutName);
                      setState(() {
                        dropdownItems.add(new DropdownMenuItem(
                          child: Text(workoutName),
                          value: workoutName,
                        ));
                        dropdownNames.add(workoutName);
                      }); 
                    }
                    print("done");
                    
                  }
                },
                child: Text('Save Workout', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 20),
              // Button to load a workout
              Container(
                margin: EdgeInsets.all(8),
                height: 40,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                ),
                child: Center(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.green[100],
                    hint: Text(
                      "Load Workout",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () async {
                      getSaved().then((value) {
                        setState(() {
                          dropdownNames = [];
                          dropdownItems = [];
                          for (int i = 0; i < value.length; i++) {
                            dropdownNames.add(value[i]);
                            dropdownItems.add(new DropdownMenuItem(
                              child: Text(value[i]),
                              value: value[i],
                            ));
                          }
                        });
                      });
                    },
                    onChanged: (String newValue) async {
                      final User user = _auth.currentUser;
                      final String uid = user.uid;
                      workout =
                          await DBService(uid: uid).getWorkoutData(newValue);
                      setState(() {
                        for (int i = 0; i < workout.length; i++) {
                          print(workout[i].name);
                        }
                        final db = DBService(uid: uid);
                        db.updateUserWorkouts(workout, days[widget.page]);
                        if (!dropdownNames.contains(days[widget.page])) {
                          dropdownItems.add(new DropdownMenuItem(
                            child: Text(days[widget.page]),
                            value: days[widget.page],
                          ));
                          dropdownNames.add(days[widget.page]);
                        }
                        if (workout.length == 0) {
                          db.deleteWorkout(days[widget.page]);
                          dropdownNames.removeWhere((item) => item == days[widget.page]);
                          dropdownItems.removeWhere((item) => item.value == days[widget.page]);
                        }
                      });
                      print("success");
                    },
                    items: dropdownItems,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: workout.length,
              itemBuilder: (context, index) {
                final item = workout[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      (() {if (item.weight == null) return 'Reps: ' + item.reps.toString(); 
                      else return 'Reps: ' + item.reps.toString() + '    Weight: '+item.weight.toString()+"lbs";})(),
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          workout.removeAt(index);
                          final User user = _auth.currentUser;
                          final String uid = user.uid;
                          final db = DBService(uid: uid);
                          if (workout.length == 0) {
                            db.deleteWorkout(days[widget.page]);
                            dropdownNames.removeWhere((item) => item == days[widget.page]);
                            dropdownItems.removeWhere((item) => item.value == days[widget.page]);
                          }else {
                            db.updateUserWorkouts(workout, days[widget.page]);
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.add),
        onPressed: () {
          _navToAddSetPage(context);
        },
        tooltip: 'Add a new Set!',
      ),
    );
  }


  // Navigator function to take us to the AddSet page.
  // This recieves a new WorkoutSet and validates it to then add it.
  _navToAddSetPage(BuildContext context) async {
    final WorkoutSet result = await Navigator.push(
      context,
      MaterialPageRoute<WorkoutSet>(builder: (context) => AddSet()),
    );
    _validateNewSet(result);
  }

  // Makes the schedule persistant even when changing tabs or pages.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return _myScheduleView();
  }
}
