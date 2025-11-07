class Patient {
  String id;
  String name;
  String gender;
  DateTime admissionDate;
  DateTime? dischargeDate;

  Patient(
    this.id,
    this.name,
    this.gender,
    this.admissionDate, [
    this.dischargeDate,
  ]);

  void displayInfo() {
    String dischargeInfo = dischargeDate == null
        ? 'Still admitted'
        : 'Discharged: ${dischargeDate!.toString().split(' ')[0]}';
    print('Patient $id: $name');
    print('  Gender: $gender');
    print('  Admitted: ${admissionDate.toString().split(' ')[0]}');
    print('  Status: $dischargeInfo');
  }

  //AI was used to help with syntax
  //store data in json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'admissionDate': admissionDate.toIso8601String(),
      'dischargeDate': dischargeDate?.toIso8601String(),
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      json['id'],
      json['name'],
      json['gender'],
      DateTime.parse(json['admissionDate']),
      json['dischargeDate'] != null ? DateTime.parse(json['dischargeDate']) : null,
    );
  }
}