import 'package:hospital_management/domain/patient.dart';
import 'package:test/test.dart';
import '../lib/domain/bed.dart';
import '../lib/domain/room.dart';

void main(){
  // print("===Testing Bed Maintenance Feature===");

  // //Create bed with differance status
  // var bed1 = Bed("A",bedStatus.Available,null);
  // var bed2 = Bed("B",bedStatus.Occupied,"P001");
  // var bed3 = Bed("C",bedStatus.Maintenance,null);

  // //Create a room
  // var room101 = Room("101","General Ward",[bed1,bed2,bed3]);

  // room101.displayInfo();

  // print("\n--- Testing Maintenance Operations ---");

  // //try to assgin patience to under maintenance bed
  // bed3.assignPatient("P002");

  // //complete maintenance
  // bed3.completeMaintenance();

  // //try again
  // bed3.assignPatient("P002");

  // bed2.underMaintenance();
  // bed2.vacate();
  // bed2.underMaintenance();

  // print("\n ---Final Status--- ");
  // room101.displayInfo();

  // print("---Patience Testing---");
  // var patient1 = Patient('P001', 'Nuka','Other',DateTime(2024, 1, 15));
  // var patient2 = Patient('P002','Lebron','Male',DateTime(2024, 1, 15));

  // patient1.displayInfo();

  // // var bed1 = Bed('A',bedStatus.Available);

  // bed1.assignPatient(patient2.id);

  // bed1.displayInfo();

  // print("\n---testing bed vacating---");
  // bed1.vacate();
  // bed1.displayInfo();


  //AI Generated test
  // GROUP 1: Testing Bed Management (Most Important Feature)
  group('Basic Bed Management Tests', () {
  // TEST 1: Can we assign a patient to an available bed?
  test('Test 1: Assign patient to available bed', () {
  // Create a bed that's available (empty)
  var bed = Bed('B101', bedStatus.Available);
  
  // Assign a patient to this bed
  bed.assignPatient('P001');
  
  // Bed should now be occupied with patient P001
  expect(bed.status, equals(bedStatus.Occupied));
  expect(bed.patientId, equals('P001'));
});

// TEST 2: Can we prevent double-booking? (Safety check)
  test('Test 2: Cannot assign patient to occupied bed', () {
  // a bed that's already occupied by patient P001
  var bed = Bed('B102', bedStatus.Occupied, 'P001');
  
  // Try to assign another patient (should fail)
  bed.assignPatient('P002');
  
  // Bed should still be occupied by original patient
  expect(bed.status, equals(bedStatus.Occupied));
  expect(bed.patientId, equals('P001')); // Should not change to P002
});

// TEST 3: free up a bed when patient leaves
  test('Test 3: Vacate bed makes it available again', () {
  // Create a bed that's currently occupied
  var bed = Bed('B103', bedStatus.Occupied, 'P001');
  
  // Patient leaves - vacate the bed
  bed.vacate();
  
  // CHECK: Bed should be available and empty
  expect(bed.status, equals(bedStatus.Available));
  expect(bed.patientId, isNull); // No patient assigned anymore
});

// TEST 4: Can we put a bed under maintenance?
  test('Test 4: Put bed under maintenance', () {
  // Create an available bed
  var bed = Bed('B104', bedStatus.Available);
  
  // Put it under maintenance (for cleaning/repairs)
  bed.underMaintenance();
  
  // CHECK: Bed should now be under maintenance
  expect(bed.status, equals(bedStatus.Maintenance));
});

// TEST 5: Can we make a maintained bed available again?
  test('Test 5: Complete maintenance makes bed available', () {
  // Create a bed that's under maintenance
  var bed = Bed('B105', bedStatus.Maintenance);
  
  // Maintenance completed - bed is ready
  bed.completeMaintenance();
  
  // Bed should be available for patients
  expect(bed.status, equals(bedStatus.Available));
    });
  });
  // GROUP 2: Testing Patient Management
  group('Basic Patient Tests', () {
    // TEST 6: create a patient with basic info
  test('Test 6: Create patient and check details', () {
  //Create a new patient
  var patient = Patient('P001', 'John Smith', 'Male', DateTime(2024, 10, 1));
  
  // All patient details should be stored correctly
  expect(patient.id, equals('P001'));
  expect(patient.name, equals('John Smith'));
  expect(patient.gender, equals('Male'));
  expect(patient.dischargeDate, isNull); // Not discharged yet (still in hospital)
});

// TEST 7: track when a patient is discharged
  test('Test 7: Patient with discharge date', () {
  // Set discharge date (when patient left hospital)
  var dischargeDate = DateTime(2024, 10, 5);
  
  // Create patient with discharge date
  var patient = Patient('P002', 'Jane Doe', 'Female', 
      DateTime(2024, 10, 1), dischargeDate);
  
  // CHECK discharge date should be stored
  expect(patient.dischargeDate, equals(dischargeDate));
  });
});
}
