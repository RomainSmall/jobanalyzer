class Job {
  String userId;
  String customername;
  String destination;
  String origin;
  double jobCost;
  double fuelCost;
  double referalFee;
  String jobDate;
  List<AdditionalDetail> additionalDetails;

  Job();

  double getExpense() {
    return this.fuelCost + this.referalFee;
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'customername': customername,
        'destination': destination,
        'origin': origin,
        'jobCost': jobCost,
        'fuelCost': fuelCost,
        'jobDate': jobDate,
        'referalFee': referalFee,
        'additionalDetails': additionalDetails.first.toJson(),
        'timeStamp': new DateTime.now(),
      };

  Job.fromMap(Map<String, dynamic> map) {
    userId = map["userId"];
    customername = map["customername"];
    destination = map["destination"];
    origin = map["origin"];
    jobCost = map["jobCost"];
    fuelCost = map["fuelCost"];
    jobDate = map["jobDate"];
    referalFee = map["referalFee"];
  }
}

class AdditionalDetail {
  String addtionalJobDetail;
  double addtionalJobCost;

  Map<String, dynamic> toJson() => {
        'addtionalJobDetail': addtionalJobDetail,
        'addtionalJobCost': addtionalJobCost,
      };
}
