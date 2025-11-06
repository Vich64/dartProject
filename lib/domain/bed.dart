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

}