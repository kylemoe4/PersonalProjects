import 'package:flutter/material.dart';
import './workoutSet.dart';
import './preset.dart';

class AddSet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddSetState();
  }
}

class _AddSetState extends State<AddSet> {
  // Loads presets for dropdown options
  PresetData presets = PresetData();

  // Intializes dropdown lists and selected items
  List<String> _groups = ['Select Group'];
  List<String> _exercises = ['Pick workout'];
  String _selectedGroup = 'Select Group';
  String _selectedExercise = 'Pick workout';

  // Makes it so selected name enters text field
  final _nameController = TextEditingController();

  String _tempName;
  int _tempReps;
  String _tempWeight;
  final _formKey = GlobalKey<FormState>();

  // Populates group dropdown with muscle groups
  @override
  void initState() {
    //_tempName = _selectedExercise;
    _groups = List.from(_groups)..addAll(presets.getGroups());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Add New Set'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Add New Set",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  items: _groups.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (value) => _onSelectedGroup(value),
                  value: _selectedGroup,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  items: _exercises.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (value) => _onSelectedExercise(value),
                  value: _selectedExercise,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Set name",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Give set a name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _tempName = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Text(
                            "# of Reps",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Rep count",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Give rep count";
                              }
                              try {
                                if (int.parse(value) < 0) {
                                  return "Give valid rep count";
                                }
                              } catch (e) {
                                return "Give valid rep count";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _tempReps = int.parse(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Text(
                            "Weight (optional)",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Weight (lbs)",
                            ),
                            validator: (value) {
                              if (value == null || value == '') return null;
                              try {
                                if (int.parse(value) < 0) {
                                  return "Give valid weight";
                                }
                              } catch (e) {
                                return "Give valid weight";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _tempWeight = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    child: Text(
                      "ADD SET",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(_tempName + " weight: " + _tempWeight.toString() + " reps: " + _tempReps.toString());
                        if (_tempWeight.trim() != '') {
                          WorkoutSet newSet =
                            new WorkoutSet(name: _tempName, reps: _tempReps, weight: int.parse(_tempWeight));
                          Navigator.of(context).pop(newSet);
                        }else {
                          WorkoutSet newSet =
                            new WorkoutSet(name: _tempName, reps: _tempReps);
                          Navigator.of(context).pop(newSet);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectedGroup(String value) {
    setState(() {
      _selectedExercise = "Select workout";
      _exercises = ["Select workout"];
      _selectedGroup = value;
      _exercises = List.from(_exercises)
        ..addAll(presets.getExercisesInGroup(value));
    });
  }

  void _onSelectedExercise(String value) {
    setState(() {
      _selectedExercise = value;
      if (value != 'Select workout') {
        _tempName = value;
        _nameController.text = value;
      }
    });
  }
}
