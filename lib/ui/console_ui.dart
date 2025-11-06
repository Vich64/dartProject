// import 'dart:io';
// import '../domain/bed.dart';
// import '../domain/patient.dart';
// import '../domain/room.dart';
// import '../data/hospital_repository.dart';

// void main() {
//   final repo = HospitalRepository();

//   // Setup sample data
//   final room1 = Room('101', RoomType.GENERAL, 3);
//   final room2 = Room('102', RoomType.ICU, 2);
//   repo.addRoom(room1);
//   repo.addRoom(room2);

//   final patient1 = Patient('P001', 'Alice Johnson', DateTime.now());
//   final patient2 = Patient('P002', 'Bob Smith', DateTime.now());
//   repo.addPatient(patient1);
//   repo.addPatient(patient2);

//   // UI Loop
//   while (true) {
//     print('\n=== Hospital Room Management ===');
//     print('1. List Rooms');
//     print('2. List Available Beds');
//     print('3. Assign Patient to Room');
//     print('4. Discharge Patient');
//     print('5. Exit');
//     final choice = _readLine('Choose: ');

//     switch (choice) {
//       case '1':
//         for (var room in repo.rooms) {
//           print(room);
//           for (var bed in room.beds) {
//             print('  $bed');
//           }
//         }
//         break;
//       case '2':
//         final rooms = repo.getRoomsWithAvailableBeds();
//         if (rooms.isEmpty) {
//           print('No available beds.');
//         } else {
//           for (var room in rooms) {
//             print('$room - Available beds: ${room.availableBeds.map((b) => b.id).join(', ')}');
//           }
//         }
//         break;
//       case '3':
//         final patientId = _readLine('Patient ID: ');
//         final patient = repo.patients.firstWhere((p) => p.id == patientId, orElse: () => null as Patient);
//         if (patient == null) {
//           print('Patient not found.');
//           break;
//         }
//         final roomsWithBeds = repo.getRoomsWithAvailableBeds();
//         if (roomsWithBeds.isEmpty) {
//           print('No available beds.');
//           break;
//         }
//         print('Available rooms:');
//         for (int i = 0; i < roomsWithBeds.length; i++) {
//           print('${i + 1}. ${roomsWithBeds[i].number}');
//         }
//         final idx = int.tryParse(_readLine('Select room # (1-${roomsWithBeds.length}): ') ?? '') ?? 0;
//         if (idx < 1 || idx > roomsWithBeds.length) {
//           print('Invalid choice.');
//           break;
//         }
//         final success = roomsWithBeds[idx - 1].assignPatientToAvailableBed(patient);
//         print(success ? 'Patient assigned.' : 'Failed to assign.');
//         break;
//       case '4':
//         final bedId = _readLine('Bed ID to discharge: ');
//         bool found = false;
//         for (var room in repo.rooms) {
//           for (var bed in room.beds) {
//             if (bed.id == bedId && bed.status == BedStatus.OCCUPIED) {
//               bed.release();
//               print('Patient discharged from $bedId');
//               found = true;
//               break;
//             }
//           }
//           if (found) break;
//         }
//         if (!found) print('Bed not occupied or not found.');
//         break;
//       case '5':
//         return;
//       default:
//         print('Invalid option.');
//     }
//   }
// }

// String _readLine(String prompt) {
//   print(prompt);
//   return stdin.readLineSync() ?? '';
// }