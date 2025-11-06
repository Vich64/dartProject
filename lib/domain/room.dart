// import 'bed.dart';
// import 'patient.dart';

// // AI generated
// enum RoomType { GENERAL, ICU, PEDIATRIC, SURGERY }

// class Room {
//   final String number;
//   final RoomType type;
//   final List<Bed> _beds = [];

//   Room(this.number, this.type, int bedCount) {
//     for (int i = 1; i <= bedCount; i++) {
//       _beds.add(Bed('$number-B$i'));
//     }
//   }

//   List<Bed> get beds => List.unmodifiable(_beds);
//   List<Bed> get availableBeds => _beds.where((b) => b.isAvailable).toList();

//   Bed? findAvailableBed() =>
//       availableBeds.isNotEmpty ? availableBeds.first : null;

//   bool assignPatientToAvailableBed(Patient patient) {
//     final bed = findAvailableBed();
//     if (bed == null) return false;
//     bed.assignPatient(patient);
//     return true;
//   }

//   @override
//   String toString() {
//     return 'Room($number, $type, Beds: ${beds.length}, Available: ${availableBeds.length})';
//   }
// }

import 'bed.dart';

class Room{
  String number;
  String types;
  List<Bed> beds;

  Room(this.number,this.types,this.beds);

  void addBed(Bed newBed){
    beds.add(newBed);
    print('Added ${newBed.id} to room $number');
  }

  //AI generated code
  //Find beds that are available
  List<Bed> getAvaibleBeds(){
    return beds.where((bed) => bed.status == bedStatus.Available).toList();
  }

  //Find beds that are under maintenance
  List<Bed> getUnderMaintenance(){
    return beds.where((bed) => bed.status == bedStatus.Maintenance).toList();
  }

  int countAvailableBeds(){
    return getAvaibleBeds().length;
  }

  int countUnderMaintenanceBeds(){
    return getUnderMaintenance().length;
  }

  void displayInfo(){
    print('Room $number ($types):');
    for(var bed in beds){
      String status = '';
      switch (bed.status){
        case bedStatus.Available:
        status = 'Available';
        break;
        case bedStatus.Occupied:
        status = 'Occupied';
        break;
        case bedStatus.Maintenance:
        status = 'Under Maintenance';
        break;
      }
      print(' - Bed ${bed.id}: $status');
    }
    print('Avaible Beds: ${countAvailableBeds()}');
    print('Bed under maintenance: ${countUnderMaintenanceBeds()}');
  }
}