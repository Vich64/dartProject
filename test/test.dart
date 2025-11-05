// import 'package:test/test.dart';

// // CORRECTED IMPORTS
// import 'package:hospital_management/domain/patient.dart';
// import 'package:hospital_management/domain/bed.dart';
// import 'package:hospital_management/domain/room.dart';

// void main() {
//   group('Domain Layer - Bed', () {
//     test('Bed assigns and releases patient correctly', () {
//       final bed = Bed('B001');
//       final patient = Patient('P1', 'John Doe', DateTime.now());

//       expect(bed.isAvailable, isTrue);
//       expect(bed.status, BedStatus.AVAILABLE);
//       expect(bed.patient, isNull);

//       bed.assignPatient(patient);

//       expect(bed.status, BedStatus.OCCUPIED);
//       expect(bed.patient?.name, 'John Doe');
//       expect(patient.assignedBed?.id, 'B001');

//       bed.release();

//       expect(bed.isAvailable, isTrue);
//       expect(bed.status, BedStatus.AVAILABLE);
//       expect(bed.patient, isNull);
//       expect(patient.assignedBed, isNull);
//     });

//     test('Cannot assign patient to occupied bed', () {
//       final bed = Bed('B002');
//       final p1 = Patient('P1', 'Alice', DateTime.now());
//       final p2 = Patient('P2', 'Bob', DateTime.now());

//       bed.assignPatient(p1);
//       expect(() => bed.assignPatient(p2), throwsException);
//     });

//     test('Cannot set occupied bed to maintenance', () {
//       final bed = Bed('B003');
//       final patient = Patient('P3', 'Charlie', DateTime.now());

//       bed.assignPatient(patient);
//       expect(() => bed.setMaintenance(), throwsException);
//     });

//     test('Can set available bed to maintenance', () {
//       final bed = Bed('B004');
//       bed.setMaintenance();
//       expect(bed.status, BedStatus.MAINTENANCE);
//       expect(bed.isAvailable, isFalse);
//     });
//   });

//   group('Domain Layer - Room', () {
//     test('Room assigns patient to available bed', () {
//       final room = Room('201', RoomType.GENERAL, 2);
//       final patient = Patient('P5', 'Mary', DateTime.now());

//       expect(room.availableBeds.length, 2);
//       final success = room.assignPatientToAvailableBed(patient);

//       expect(success, isTrue);
//       expect(room.availableBeds.length, 1);
//       expect(patient.assignedBed, isNotNull);
//       expect(patient.assignedBed!.id, startsWith('201-B'));
//     });

//     test('Cannot assign patient if no beds available', () {
//       final room = Room('202', RoomType.ICU, 1);
//       final p1 = Patient('P6', 'X', DateTime.now());
//       final p2 = Patient('P7', 'Y', DateTime.now());

//       expect(room.assignPatientToAvailableBed(p1), isTrue);
//       expect(room.assignPatientToAvailableBed(p2), isFalse);
//       expect(room.availableBeds.length, 0);
//     });

//     test('Room lists available beds correctly', () {
//       final room = Room('203', RoomType.PEDIATRIC, 3);
//       final p1 = Patient('P8', 'Kid1', DateTime.now());

//       expect(room.availableBeds.length, 3);
//       room.assignPatientToAvailableBed(p1);
//       expect(room.availableBeds.length, 2);
//     });
//   });

//   group('Domain Layer - Patient', () {
//     test('Patient can be assigned to only one bed', () {
//       final bed1 = Bed('B100');
//       final bed2 = Bed('B101');
//       final patient = Patient('P10', 'Sam', DateTime.now());

//       bed1.assignPatient(patient);
//       expect(() => bed2.assignPatient(patient), throwsException);
//     });

//     test('Discharge clears bed assignment', () {
//       final bed = Bed('B200');
//       final patient = Patient('P11', 'Tom', DateTime.now());

//       bed.assignPatient(patient);
//       expect(patient.assignedBed, isNotNull);

//       bed.release();
//       expect(patient.assignedBed, isNull);
//     });
//   });
// }

import '../lib/domain/bed.dart';
import '../lib/domain/room.dart';

void main(){
  print("===Testing Bed Maintenance Feature===");

  //Create bed with differance status
  var bed1 = Bed("A",bedStatus.Available,null);
  var bed2 = Bed("B",bedStatus.Occupied,"P001");
  var bed3 = Bed("C",bedStatus.Maintenance,null);

  //Create a room
  var room101 = Room("101","General Ward",[bed1,bed2,bed3]);

  room101.displayInfo();

  print("\n--- Testing Maintenance Operations ---");

  //try to assgin patience to under maintenance bed
  bed3.assignPatient("P002");

  //complete maintenance
  bed3.completeMaintenance();

  //try again
  bed3.assignPatient("P002");

  bed2.underMaintenance();
  bed2.vacate();
  bed2.underMaintenance();

  print("\n ---Final Status--- ");
  room101.displayInfo();
}
