import 'package:jobs/models/job.dart';
import 'package:jobs/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference jobCollection =
      Firestore.instance.collection('Jobs');

  Future<void> updateUserData(String name) async {
    return await jobCollection.document(uid).setData({'name': name});
  }

  Future<void> addJobDetails(customername, destination, origin, jobCost,
      fuelCost, referalFee, additionalDetails) async {
    return await jobCollection.document(uid).setData({
      'customername': customername,
      'destination': destination,
      'origin': origin,
      'jobCost': jobCost,
      'fuelCost': fuelCost,
      'referalFee': referalFee,
      'additionalDetails': {
        'addttionalDetailName': 'TOLL MONEY',
        'addttionalDetailCost': 0,
      }
    });
  }

  // job list from snapshot
  List<Job> _jobListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Job(
          //  doc.data['customername'] ?? '',
          //  doc.data['destination'] ?? '',
          //  doc.data['origin'] ?? '',
          //  doc.data['jobCost'] ?? 0,
          //  doc.data['fuelCost'] ?? 0,
          //  doc.data['referalFee'] ?? 0,
          //  null
          );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot.data['name']);
  }

  // // get brews stream
  Stream<List<Job>> get jobs {
    return jobCollection.snapshots().map(_jobListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return jobCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
