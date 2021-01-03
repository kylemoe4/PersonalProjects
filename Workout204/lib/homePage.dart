import 'package:flutter/material.dart';
import './workoutSchedule.dart';

class HomePage extends StatefulWidget {
  final Function toggleView;
  HomePage({this.toggleView});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {
  //DateTime date = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      initialIndex: DateTime.now().weekday%7,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Sun",
              ),
              Tab(
                text: "Mon",
              ),
              Tab(
                text: "Tue",
              ),
              Tab(
                text: "Wed",
              ),
              Tab(
                text: "Thu",
              ),
              Tab(
                text: "Fri",
              ),
              Tab(
                text: "Sat",
              ),
            ],
          ),
          title: Center(
            child: Text('Workout Schedule'),
          ),
        ),
        body: TabBarView(
          children: [
            Schedule(page:0),
            Schedule(page:1),
            Schedule(page:2),
            Schedule(page:3),
            Schedule(page:4),
            Schedule(page:5),
            Schedule(page:6),
          ],
        ),
      ),
    );
  }
}
