import 'package:flutter/material.dart';

class WorkoutSet {
  String name;
  int reps;
  int weight;

  WorkoutSet({
    @required this.name,
    @required this.reps,
    this.weight,
  });
}
