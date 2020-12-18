class Medication {
  final String fullName;

  Medication({this.fullName});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(fullName: json['fullName']);
  }
}
