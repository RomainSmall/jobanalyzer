import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jobs/models/job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CreateJobView extends StatefulWidget {
  @override
  _CreateJobViewState createState() => _CreateJobViewState();
}

class _CreateJobViewState extends State<CreateJobView> {
  final dbConnnection = Firestore.instance;

  AdditionalDetail details = new AdditionalDetail();

  Job newJob = new Job();

  final GlobalKey<FormBuilderState> _formKey =
      new GlobalKey<FormBuilderState>();

  Future _submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var _currentUser = await FirebaseAuth.instance.currentUser();

      newJob.additionalDetails = new List<AdditionalDetail>();
      newJob.additionalDetails.add(details);
      newJob.userId = _currentUser.uid;
      var result = await dbConnnection
          .collection("Job")
          .add(newJob.toJson())
          .whenComplete(() => showInSnackBar('Successfully Added'))
          .catchError((err) => showInSnackBar('Unexpected Error! retry '))
          .then((value) => _formKey.currentState.reset())
          .then((value) => 'true');

      if (result.toString().contains('true')) {
        Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pop())
            .catchError((err) => showInSnackBar('Unexpected Error! retry '));
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Create Jobs'),
      ),
      body: Builder(
        builder: (contect) => new SafeArea(
          top: false,
          bottom: false,
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'date': DateTime.now(),
              'accept_terms': false,
            },
            autovalidate: true,
            child: new ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              children: <Widget>[
                TextFormField(
                  initialValue: 'test',
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Enter Customer Name',
                    labelText: 'Customer Name',
                  ),
                  validator: (input) =>
                      !input.isNotEmpty ? 'Please Enter Customer Name' : null,
                  onSaved: (input) => newJob.customername = input,
                  autofocus: true,
                ),
                TextFormField(
                  initialValue: '20000',
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.attach_money),
                    hintText: 'Enter Job Cost',
                    labelText: 'Job Cost',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (input) =>
                      !input.isNotEmpty ? 'Please Enter Job Cost' : null,
                  onSaved: (input) => newJob.jobCost = double.tryParse(input),
                ),
                FormBuilderDateTimePicker(
                  attribute: "date",
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                  onSaved: (input) => newJob.jobDate = input.toString(),
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.calendar_today),
                    hintText: 'Enter Job Date',
                    labelText: 'Job Date',
                  ),
                ),
                TextFormField(
                  initialValue: '2000',
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.attach_money),
                    hintText: 'Enter Fuel Cost',
                    labelText: 'Fuel Cost',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (input) =>
                      !input.isNotEmpty ? 'Please Enter Fuel Cost' : null,
                  onSaved: (input) => newJob.fuelCost = double.tryParse(input),
                ),
                TextFormField(
                  initialValue: '2000',
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.attach_money),
                    hintText: 'Enter Referal Fee',
                    labelText: 'Referal Fee',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (input) =>
                      !input.isNotEmpty ? 'Please Enter Referal Fee' : null,
                  onSaved: (input) =>
                      newJob.referalFee = double.tryParse(input),
                ),
                TextFormField(
                  initialValue: 'active',
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.my_location),
                    hintText: 'Enter Origin',
                    labelText: 'Origin',
                  ),
                  validator: (input) =>
                      !input.isNotEmpty ? 'Please Enter Origin' : null,
                  onSaved: (input) => newJob.origin = input,
                  autofocus: true,
                ),
                TextFormField(
                  initialValue: 'ochi',
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.location_on),
                    hintText: 'Enter Destination',
                    labelText: 'Destination',
                  ),
                  validator: (input) =>
                      !input.isNotEmpty ? 'Please Enter Destination' : null,
                  onSaved: (input) => newJob.destination = input,
                  autofocus: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text('Addtioanl Details: '),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        initialValue: 'side man',
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.details),
                          hintText: 'Addtional Details',
                          labelText: 'Addtional Details',
                        ),
                        validator: (input) => !input.isNotEmpty
                            ? 'Please Addtional Details'
                            : null,
                        onSaved: (input) => details.addtionalJobDetail = input,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: '2000',
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.attach_money),
                          hintText: 'Cost',
                          labelText: 'Cost',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (input) =>
                            !input.isNotEmpty ? 'Please Enter Cost' : null,
                        onSaved: (input) =>
                            details.addtionalJobCost = double.tryParse(input),
                      ),
                    ),
                  ],
                ),
                new Container(
                  padding: const EdgeInsets.only(
                      left: 100.0, right: 100, top: 10.0, bottom: 40.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () async {
                            _submit(context);
                          },
                          child: Text('Submit'),
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            showInSnackBar('Resetting Data');
                            _formKey.currentState.reset();
                          },
                          child: Text('reset'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// 'Enter Customer Name',
// 'Enter Destination'
// 'Enter Origin'
// 'Enter Job Cost'
// 'Enter Fuel Cost '
// 'Enter Referal Fee '
}
