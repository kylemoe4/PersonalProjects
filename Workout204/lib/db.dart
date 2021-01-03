import 'package:cloud_firestore/cloud_firestore.dart';
import './workoutSet.dart';
import 'dart:convert';


class DBService{

  final String uid;
  DBService({this.uid});

  final CollectionReference workOut= FirebaseFirestore.instance.collection('Workouts');
  Future updateUserData(String name) async{
    return await workOut.doc(uid).set({
      'name': name,
      'height': '',
      'weight': '',
    });
  }

  Future getName() async{
    String name;
    await workOut.doc(uid).get().then((value) {
      name = value.data()['name'];
    });
    return name;
  }
  Future getHeight() async{
    String height;
    await workOut.doc(uid).get().then((value) {
      height = value.data()['height'];
    });
    return height;
  }
  Future getWeight() async{
    String weight;
    await workOut.doc(uid).get().then((value) {
      weight = value.data()['weight'];
    });
    return weight;
  }
  Future setname(String name) async{
    return await workOut.doc(uid).update({
      'name': name,
    });
  }
  Future setheight(String height) async{
    return await workOut.doc(uid).update({
      'height': height,
    });
  }
  Future setweight(String weight) async{
    return await workOut.doc(uid).update({
      'weight': weight,
    });
  }


  Future deleteWorkout(String name) async {
    await workOut.doc(uid).collection("savedWorkouts").where("workoutName", isEqualTo : name).get().then((value){
      value.docs.forEach((element) {
        workOut.doc(uid).collection("savedWorkouts").doc(element.id).delete().then((value){
          print("Deleted!");
        });
      });
    });
  }

  Future updateUserWorkouts(List<WorkoutSet> newWorkout, String workoutName) async {
    String _toAdd = '''
      {
        "workoutName": "'''+workoutName+'''",
        "sets": [ ''';
    for (int i = 0; i < newWorkout.length; i++) {
      _toAdd += '''
          {
            "name":"'''+newWorkout[i].name.toString()+'''",
            "reps":"'''+newWorkout[i].reps.toString()+'''"''';
          /*{
            "name":"'''+newWorkout[i].name.toString()+'''",
            "reps":"'''+newWorkout[i].reps.toString()+'''"
          }''';*/
      if (newWorkout[i].weight != null) {
        _toAdd += ''',"weight":"'''+newWorkout[i].weight.toString()+'''"''';
      }
      _toAdd += '''}''';
      if (i < newWorkout.length-1) {
        _toAdd += ''',''';
      }
    }
    _toAdd += ''' 
        ]
      }
    ''';
    print(_toAdd);

    await workOut.doc(uid).collection("savedWorkouts").where("workoutName", isEqualTo : workoutName).get().then((value){
      value.docs.forEach((element) {
        workOut.doc(uid).collection("savedWorkouts").doc(element.id).delete().then((value){
          print("Success!");
        });
      });
      workOut.doc(uid).collection("savedWorkouts").add(
        jsonDecode(_toAdd)
      );
    });
  }

  Future getWorkoutData(String workoutName) async {
    List<WorkoutSet> loaded = new List<WorkoutSet>();
    await workOut.doc(uid).collection("savedWorkouts").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (result.get("workoutName") == workoutName) {
          var sets = result.get("sets");
          print(sets.runtimeType);
          for (int i = 0; i < sets.length; i++) {
            print(sets[i]["name"]);
            print(sets[i]["reps"]);
            if (sets[i]["weight"] != null) {
              WorkoutSet newSet = new WorkoutSet(name: sets[i]["name"], reps: int.parse(sets[i]["reps"]), weight: int.parse(sets[i]["weight"]));
              loaded.add(newSet);
            }else {
              WorkoutSet newSet = new WorkoutSet(name: sets[i]["name"], reps: int.parse(sets[i]["reps"]));
              loaded.add(newSet);
            }
          }
        }
      });
    });
    return loaded;
  }

  Future getSavedWorkoutNames() async {
    List<String> names = new List<String>();
    await workOut.doc(uid).collection("savedWorkouts").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        names.add(result.get("workoutName"));
      });
    });
    return names;
  }

  /*Future getName() async {
    String name;
    await workOut.doc(uid).get().then((value) {
      name = value.data()['name'];
    });
    return name;
  }*/
}