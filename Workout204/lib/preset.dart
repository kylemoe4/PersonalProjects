// Just class defintions so we dont need any imports

class PresetCategrory {
  String group;
  List<String> exercises;

  PresetCategrory({this.group, this.exercises});

  PresetCategrory.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    exercises = json['exercises'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['exercises'] = this.exercises;
    return data;
  }
}

class PresetData {
  List<Map> getAll() => _presets;

  List<String> getGroups() => _presets
      .map((map) => PresetCategrory.fromJson(map))
      .map((item) => item.group)
      .toList();

  getExercisesInGroup(String group) => _presets
      .map((map) => PresetCategrory.fromJson(map))
      .where((item) => item.group == group)
      .map((item) => item.exercises)
      .expand((i) => i)
      .toList();

  List _presets = [
    {
      'group': 'Chest',
      'exercises': [
        'Bench press',
        'Bench press (incline)',
        'Bench press (decline)',
        'Dumbell bench press',
        'Dumbell chest fly',
        'Push-ups',
      ]
    },
    {
      'group': 'Back',
      'exercises': [
        'Deadlift',
        'Rows',
        'Olympic Lift',
        'T-Bar rows',
        'Dumbell rows',
        'Pull-ups',
        'Chin-ups',
      ]
    },
    {
      'group': 'Legs',
      'exercises': [
        'Barbell Squats',
        'Dumbell Squats',
        'Lunges',
        'High-Step',
        'Deadlift',
        'Hip thrust',
        'Calf raises',
        'Leg press',
      ]
    },
    {
      'group': 'Shoulders',
      'exercises': [
        'Dumbell shoulder press',
        'Seated shoulder press',
        'Dumbell lateral raises',
        'Dumbell front raises',
        'Dumbell reverse flys',
      ]
    },
    {
      'group': 'Biceps',
      'exercises': [
        'Barbell curl',
        'Dumbell curl',
        'Concentration curl',
        'Hammer curl',
        'Pull-ups',
      ]
    },
    {
      'group': 'Triceps',
      'exercises': [
        'Bench press',
        'Skull crushers',
        'Tricep kickbacks',
        'Overhead dumbell extension',
        'Push-ups',
        'Dips',
      ]
    },
    {
      'group': 'Abs',
      'exercises': [
        'Ab rollouts',
        'Sit-ups',
        'Crunches',
        'Plank',
        'Side plank',
        'Russian twists',
        'Leg raises',
        'Hip raises',
      ]
    }
  ];
}
