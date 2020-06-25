import 'package:jobs/models/job.dart';
import 'package:flutter/material.dart';

class JobTile extends StatelessWidget {

  final Job job;
  JobTile({ this.job });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(job.customername),
          subtitle: Text('Going to: ${job.destination}'),
        ),
      ),
    );
  }
}