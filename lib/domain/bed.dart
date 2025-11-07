enum bedStatus{Available,Occupied,Maintenance}

class Bed {
  String id;
  bedStatus status;
  String? patientId;

  Bed(this.id,this.status,[this.patientId]);

  void assignPatient(String patientId){
    if (status != bedStatus.Available){
      print('Cannot allocate bed $id - it is occupied or under maintenance');
      return;
    }
    status = bedStatus.Occupied;
    this.patientId = patientId;
    print('Bed $id assign to patient $patientId');
  }


  void vacate(){
    if (status != bedStatus.Occupied){
      print('Bed $id is no longer occupied');
      return;
    }
    status = bedStatus.Available;
    patientId = null;
    print('Bed $id is now available');
  }

  void underMaintenance(){
    if (status == bedStatus.Occupied){
      print('Cannot put bed $id under maintenance - it is occupied');
      return;
    }
    status = bedStatus.Maintenance;
    patientId = null;
    print('Bed $id is now under maintenace');
  }

  void completeMaintenance(){
    if (status != bedStatus.Maintenance){
      print('Bed $id is no longer under maintenance');
      return;
    }
    status = bedStatus.Available;
    print('Bed $id maintenance completed - now avaliable');

  }

  void displayInfo(){
    String statusText = '';
    switch (status){
      case bedStatus.Available:
      statusText = 'Available';
      break;
      case bedStatus.Occupied:
      statusText = 'Occupied';
      break;
      case bedStatus.Maintenance:
      statusText = 'Under Maintenance';
      break;
    }
    print("Bed $id: $statusText");


  }

  bool get canbeAssign => status == bedStatus.Available;

    // JSON methods:
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': _bedStatusToString(status),
      'patientId': patientId,
    };
  }

  factory Bed.fromJson(Map<String, dynamic> json) {
    return Bed(
      json['id'],
      _stringToBedStatus(json['status']),
      json['patientId'],
    );
  }

  static String _bedStatusToString(bedStatus status) {
    switch (status) {
      case bedStatus.Available:
        return 'Available';
      case bedStatus.Occupied:
        return 'Occupied';
      case bedStatus.Maintenance:
        return 'Maintenance';
    }
  }

  static bedStatus _stringToBedStatus(String status) {
    switch (status) {
      case 'Available':
        return bedStatus.Available;
      case 'Occupied':
        return bedStatus.Occupied;
      case 'Maintenance':
        return bedStatus.Maintenance;
      default:
        return bedStatus.Available;
    }
  }

}