import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:jobs/models/job.dart';
import 'package:jobs/views/home/create_job.dart';
import 'package:jobs/views/home/job_list.dart';
import 'package:jobs/views/home/settings_form.dart';
import 'package:jobs/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _CreateHomeView createState() => _CreateHomeView();
}

class _CreateHomeView extends State<Home> {
  final AuthService _auth = AuthService();
  UsersJobs userJobs = new UsersJobs();
  List<Job> jobList = new List<Job>();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    Future _loadJobs(BuildContext context) async {
      var _currentUser = await FirebaseAuth.instance.currentUser();
      jobList = await userJobs.getJobsFromDb(_currentUser.uid.toString());
    }

    _loadJobs(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reliant Trucking'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('settings'),
            onPressed: () => _showSettingsPanel(),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/isuzu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: jobList.length == 0
            ? new Text('NO JOBS AVAIABLE')
            : new ListView.builder(
                itemCount: jobList.length,
                itemBuilder: (context, index) {
                  return jobUi(jobList[index], context);
                }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[600],
        elevation: 1,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateJobView()));
        },
      ),
    );
  }

  Widget jobUi(Job job, BuildContext context) {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        padding: new EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(
                  job.customername,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Spacer(),
                new Text(
                  job.jobDate,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                new Text(
                  'From: ' + job.destination,
                  textAlign: TextAlign.left,
                ),
                Spacer(),
                new Text(
                  'To: ' + job.origin,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                new Text(
                  'Income: ' + job.jobCost.toString(),
                  textAlign: TextAlign.left,
                ),
                Spacer(),
                new Text(
                  'Expense: ' + job.getExpense().toString(),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  'Job Cost: ' + job.jobCost.toString(),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                new Text(
                  'Fuel Cost: ' + job.fuelCost.toString(),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                new Text(
                  'Ref Fee: ' + job.referalFee.toString(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
