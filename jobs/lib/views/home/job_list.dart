import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs/models/job.dart';

class UsersJobs {
  Future<List<Job>> getJobsFromDb(String userId) async {
    List<Job> jobList = new List<Job>();
    final dbConnnection = Firestore.instance;

    await dbConnnection.collection('Job').getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Job job = new Job();
        job.customername = _toString(result.data['customername'].toString());
        job.destination = _toString(result.data['destination']);
        job.jobCost = _toNumber(result.data['jobCost']);
        job.jobDate = _toString(result.data['jobDate']);
        job.origin = _toString(result.data['origin']);
        job.fuelCost = _toNumber(result.data['fuelCost']);
        job.referalFee = _toNumber(result.data['referalFee']);

        jobList.add(job);
      });
    });
    return jobList;
  }

  double _toNumber(amt) {
    return amt.isNaN ? 0 : amt;
  }

  String _toString(String str) {
    return str.isNotEmpty ? str : '';
  }
}
