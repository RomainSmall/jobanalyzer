import 'package:jobs/models/user.dart';
//import 'package:jobs/services/database.dart';
import 'package:jobs/shared/constants.dart';
import 'package:jobs/shared/loading.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _customername;
  String _destination;
  String _origin;
  double _jobCost;
  double _fuelCost;
  double _referalFee;
  List<String> additionalDetails;

  @override
  Widget build(BuildContext context) {
    //user user = Provider.of<User>(context);

    // return StreamBuilder<UserData>(
    //  // stream: DatabaseService(uid: user.uid).userData,
    //   builder: (context, snapshot) {
    //     if(0==0){
    // if(snapshot.hasData){
    //UserData userData = snapshot.data;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your brew settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            initialValue: 'Enter Customer Name',
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Enter Customer Name' : null,
            onChanged: (val) => setState(() => _customername = val),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            initialValue: 'Enter Destination',
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Enter Destination' : null,
            onChanged: (val) => setState(() => _destination = val),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            initialValue: 'Enter Origin',
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Enter Origin' : null,
            onChanged: (val) => setState(() => _origin = val),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            initialValue: 'Enter Job Cost',
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Enter Job Cost' : null,
            onChanged: (val) => setState(() => _jobCost = 0),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            initialValue: 'Enter Fuel Cost ',
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Enter Fuel Cost ' : null,
            onChanged: (val) => setState(() => _fuelCost = 0),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            initialValue: 'Enter Referal Fee ',
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Enter Referal Fee ' : null,
            onChanged: (val) => setState(() => _referalFee = 0),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Add Job',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                // if(_formKey.currentState.validate()){
                //   await DatabaseService(uid: user.uid).addJobDetails(
                //    _customername ?? "",
                //     _destination ??  "",
                //     _origin ??  "",
                //     _jobCost ?? 0,
                //     _fuelCost ?? 0,
                //     _referalFee ?? 0,
                //     additionalDetails ?? Null
                //   );
                //   Navigator.pop(context);
                // }
              }),
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
