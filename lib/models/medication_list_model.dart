class Medication {
  final String id;
  final String fullName;

  Medication({this.id, this.fullName});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(fullName: json['fullName']);
  }

  factory Medication.fromMap(Map<String, dynamic> json) {
    return Medication(id: json["id"], fullName: json["fullName"]);
  }

  Map<String, dynamic> toMap() => {"id": id, "fullName": fullName};
}
