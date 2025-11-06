import 'package:hospital_management/domain/patient.dart';

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

  print("---Patience Testing---");
  var patient1 = Patient('P001', 'Nuka');
  var patient2 = Patient('P002','Lebron');

  patient1.displayInfo();

  // var bed1 = Bed('A',bedStatus.Available);

  bed1.assignPatient(patient2.id);

  bed1.displayInfo();

  print("\n---testing bed vacating---");
  bed1.vacate();
  bed1.displayInfo();

}
