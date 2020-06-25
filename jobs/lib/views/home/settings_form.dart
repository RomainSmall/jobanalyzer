import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'Update your user settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'To be implemented',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 30.0),
        ],
      ),
    );
    // } else {
    //   return Loading();
    // }
    //   }
    // );
  }
}
