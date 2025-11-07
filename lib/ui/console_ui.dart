import 'dart:io';
import '../domain/bed.dart';
import '../domain/room.dart';
import '../domain/patient.dart';
import '../data/hospital_repository.dart';

class HospitalManager {
  List<Room> rooms = [];
  List<Patient> patients = [];
  Repository repository = Repository();

  void start() {
    print('=== Hospital Room Management System ===');
    // setupSampleData();
    loadData();
    showMainMenu();
  }

  void setupSampleData() {
    print('Setting up sample data...');

    // Sample patients
    patients.addAll([
      Patient('P001', 'Ronaldo'),
      Patient('P002', 'Messi'),
      Patient('P003', 'Ryan'),
      Patient('P004', 'Ghostlin'),
    ]);

    // Sample rooms
    rooms.addAll([
      Room('A001', 'General Ward', [
        Bed('A', bedStatus.Available),
        Bed('B', bedStatus.Available),
        Bed('C', bedStatus.Available),
      ]),
      Room('A002', 'Private', [
        Bed('A1', bedStatus.Available),
        Bed('A2', bedStatus.Available),
        Bed('B1', bedStatus.Occupied, 'P001'),
        Bed('B2', bedStatus.Maintenance),
      ]),
    ]);

    print('Sample data ready!');
    print('Created ${patients.length} patients and ${rooms.length} rooms');
  }


    //AI generated code 
    //save data to json file
    void loadData() {
    print('Loading data...');
    
    // Try to load from files
    patients = repository.loadPatients();
    rooms = repository.loadRooms();
    
    // If no data exists, create sample data and save it
    if (patients.isEmpty && rooms.isEmpty) {
      print('No saved data found. ');
      setupSampleData();
      saveData();
    } else {
      print('Data loaded successfully!');
      print('Loaded ${patients.length} patients and ${rooms.length} rooms');
    }
  }

  void saveData() {
    repository.savePatients(patients);
    repository.saveRooms(rooms);
    print('Data saved successfully!');
  }


  void clearConsole() {
    print('\x1B[2J\x1B[0;0H');
  }

  void showMainMenu() {
    while (true) {
      clearConsole();
      print('=== Hospital Room Management System ===');
      print('\n=== Main Menu ===');
      print('1. View all rooms status');
      print('2. Assign a bed to patient');
      print('3. Vacate a bed');
      print('4. Put bed under maintenance');
      print('5. Complete bed maintenance');
      print('6. Add new room');
      print('7. View all patients');
      print('8. Exit');
      print('Choose an option (1-8): ');

      String? input = stdin.readLineSync();
      clearConsole();

      switch (input) {
        case '1':
          viewAllRooms();
          break;
        case '2':
          assignBed();
          break;
        case '3':
          vacateBed();
          break;
        case '4':
          putBedUnderMaintenance();
          break;
        case '5':
          completeMaintenance();
          break;
        case '6':
          addNewRoom();
          break;
        case '7':
          viewAllPatients();
          break;
        case '8':
          print('Exiting...');
          return;
        default:
          print('Invalid option. Please choose 1-8.');
          print('Press enter to continue...');
          stdin.readLineSync();
      }
    }
  }

  //view all room feature
  void viewAllRooms() {
    print('=== ALL ROOMS STATUS ===');
    if (rooms.isEmpty) {
      print('No rooms available.');
      print('Press enter to continue...');
      stdin.readLineSync();
      return;
    }

    for (var room in rooms) {
      print('\n--- Room ${room.number} (${room.types}) ---');
      for (var bed in room.beds) {
        String status = '';
        String patientInfo = '';
        
        switch (bed.status) {
          case bedStatus.Available:
            status = 'AVAILABLE';
            break;
          case bedStatus.Occupied:
            var patient = _findPatientById(bed.patientId!);
            status = 'OCCUPIED';
            patientInfo = ' by ${patient.name}';
            break;
          case bedStatus.Maintenance:
            status = 'UNDER MAINTENANCE';
            break;
        }
        print('  Bed ${bed.id}: $status$patientInfo');
      }
      print('Summary: ${room.countAvailableBeds()} available, ' +
            '${room.countOccupiedBeds()} occupied, ' +
            '${room.countUnderMaintenanceBeds()} under maintenance');
    }
    print('\nPress enter to continue...');
    stdin.readLineSync();
  }


  //view all patient feature
  void viewAllPatients() {
    print('=== ALL PATIENTS ===');
    if (patients.isEmpty) {
      print('No patients registered.');
      print('Press enter to continue...');
      stdin.readLineSync();
      return;
    }

    for (var patient in patients) {
      patient.displayInfo();
    }
    print('\nPress enter to continue...');
    stdin.readLineSync();
  }

  void assignBed() {
    while (true) {
      clearConsole();
      print('=== ASSIGN BED TO PATIENT ===');
      print('0. Back to Main Menu');
      
      var availableBeds = <Bed>[];
      for (var room in rooms) {
        availableBeds.addAll(room.getAvailableBeds());
      }

      if (availableBeds.isEmpty) {
        print('No available beds found!');
        print('Press enter to continue...');
        stdin.readLineSync();
        return;
      }

      print('\nAvailable beds:');
      for (int i = 0; i < availableBeds.length; i++) {
        var bed = availableBeds[i];
        var room = _findRoomForBed(bed);
        print('${i + 1}. Room ${room!.number} - Bed ${bed.id}');
      }

      print('\nSelect a bed (1-${availableBeds.length}) or 0 to go back: ');
      String? input = stdin.readLineSync();
      int? bedSelection = int.tryParse(input ?? '');

      if (bedSelection == 0) {
        return;
      }

      if (bedSelection == null || bedSelection < 1 || bedSelection > availableBeds.length) {
        print('Invalid bed selection!');
        print('Press enter to continue...');
        stdin.readLineSync();
        continue;
      }

      var selectedBed = availableBeds[bedSelection - 1];

      while (true) {
        clearConsole();
        print('Select a patient for Bed ${selectedBed.id}:');
        print('0. Back to Bed Selection');
        
        for (int i = 0; i < patients.length; i++) {
          print('${i + 1}. ${patients[i].name} (${patients[i].id})');
        }

        print('\nChoose patient (1-${patients.length}) or 0 to go back: ');
        input = stdin.readLineSync();
        int? patientSelection = int.tryParse(input ?? '');

        if (patientSelection == 0) {
          break;
        }

        if (patientSelection == null || patientSelection < 1 || patientSelection > patients.length) {
          print('Invalid patient selection!');
          print('Press enter to continue...');
          stdin.readLineSync();
          continue;
        }

        var selectedPatient = patients[patientSelection - 1];
        selectedBed.assignPatient(selectedPatient.id);
        print('${selectedPatient.name} assigned to Bed ${selectedBed.id}');
        print('Press enter to continue...');
        saveData();
        stdin.readLineSync();
        return;
      }
    }
  }

  // patience leave
  void vacateBed() {
    while (true) {
      clearConsole();
      print('=== VACATE BED ===');
      print('0. Back to Main Menu');
      
      var occupiedBeds = <Bed>[];
      for (var room in rooms) {
        occupiedBeds.addAll(room.getOccupiedBeds());
      }

      if (occupiedBeds.isEmpty) {
        print('No occupied beds found!');
        print('Press enter to continue...');
        stdin.readLineSync();
        return;
      }

      print('\nOccupied beds:');
      for (int i = 0; i < occupiedBeds.length; i++) {
        var bed = occupiedBeds[i];
        var room = _findRoomForBed(bed);
        var patient = _findPatientById(bed.patientId!);
        print('${i + 1}. Room ${room!.number} - Bed ${bed.id} (${patient.name})');
      }

      print('\nSelect a bed to vacate (1-${occupiedBeds.length}) or 0 to go back: ');
      String? input = stdin.readLineSync();
      int? selection = int.tryParse(input ?? '');

      if (selection == 0) {
        return;
      }

      if (selection == null || selection < 1 || selection > occupiedBeds.length) {
        print('Invalid selection!');
        print('Press enter to continue...');
        stdin.readLineSync();
        continue;
      }

      var selectedBed = occupiedBeds[selection - 1];
      var patient = _findPatientById(selectedBed.patientId!);
      
      selectedBed.vacate();
      print('Bed ${selectedBed.id} vacated. ${patient.name} has been discharged.');
      print('Press enter to continue...');
      stdin.readLineSync();
      saveData();
      return;
    }
  }

  //put bed under maintenance
  void putBedUnderMaintenance() {
    while (true) {
      clearConsole();
      print('=== PUT BED UNDER MAINTENANCE ===');
      print('0. Back to Main Menu');
      
      var availableBeds = <Bed>[];
      for (var room in rooms) {
        availableBeds.addAll(room.getAvailableBeds());
      }

      if (availableBeds.isEmpty) {
        print('No available beds found! (Only available beds can be put under maintenance)');
        print('Press enter to continue...');
        stdin.readLineSync();
        return;
      }

      print('\nAvailable beds (can be put under maintenance):');
      for (int i = 0; i < availableBeds.length; i++) {
        var bed = availableBeds[i];
        var room = _findRoomForBed(bed);
        print('${i + 1}. Room ${room!.number} - Bed ${bed.id}');
      }

      print('\nSelect a bed to put under maintenance (1-${availableBeds.length}) or 0 to go back: ');
      String? input = stdin.readLineSync();
      int? selection = int.tryParse(input ?? '');

      if (selection == 0) {
        return;
      }

      if (selection == null || selection < 1 || selection > availableBeds.length) {
        print('Invalid selection!');
        print('Press enter to continue...');
        stdin.readLineSync();
        continue;
      }

      var selectedBed = availableBeds[selection - 1];
      selectedBed.underMaintenance();
      print('Bed ${selectedBed.id} is now under maintenance.');
      print('Press enter to continue...');
      stdin.readLineSync();
      saveData();
      return;
    }
  }

  //complete bed maintenance
  void completeMaintenance() {
    while (true) {
      clearConsole();
      print('=== COMPLETE BED MAINTENANCE ===');
      print('0. Back to Main Menu');
      
      var maintenanceBeds = <Bed>[];
      for (var room in rooms) {
        maintenanceBeds.addAll(room.getUnderMaintenance());
      }

      if (maintenanceBeds.isEmpty) {
        print('No beds under maintenance found!');
        print('Press enter to continue...');
        stdin.readLineSync();
        return;
      }

      print('\nBeds under maintenance:');
      for (int i = 0; i < maintenanceBeds.length; i++) {
        var bed = maintenanceBeds[i];
        var room = _findRoomForBed(bed);
        print('${i + 1}. Room ${room!.number} - Bed ${bed.id}');
      }

      print('\nSelect a bed to complete maintenance (1-${maintenanceBeds.length}) or 0 to go back: ');
      String? input = stdin.readLineSync();
      int? selection = int.tryParse(input ?? '');

      if (selection == 0) {
        return;
      }

      if (selection == null || selection < 1 || selection > maintenanceBeds.length) {
        print('Invalid selection!');
        print('Press enter to continue...');
        stdin.readLineSync();
        continue;
      }

      var selectedBed = maintenanceBeds[selection - 1];
      selectedBed.completeMaintenance();
      print('Bed ${selectedBed.id} maintenance completed - now available for patients.');
      print('Press enter to continue...');
      stdin.readLineSync();
      saveData();
      return;
    }
  }

  //add new room
  void addNewRoom() {
    while (true) {
      clearConsole();
      print('=== ADD NEW ROOM ===');
      print('0. Back to Main Menu');
      
      print('Enter room number (or 0 to go back): ');
      String? roomNumber = stdin.readLineSync()?.trim();
      
      if (roomNumber == '0') {
        return;
      }
      
      if (roomNumber == null || roomNumber.isEmpty) {
        print('Room number cannot be empty!');
        print('Press enter to continue...');
        stdin.readLineSync();
        continue;
      }

      if (rooms.any((room) => room.number == roomNumber)) {
        print('Room $roomNumber already exists!');
        print('Press enter to continue...');
        stdin.readLineSync();
        continue;
      }

      print('Enter room type (e.g., General Ward, Private, ICU) or 0 to go back: ');
      String? roomType = stdin.readLineSync()?.trim();
      
      if (roomType == '0') {
        return;
      }
      
      if (roomType == null || roomType.isEmpty) {
        print('Room type cannot be empty!');
        print('Press enter to continue...');
        stdin.readLineSync();
        continue;
      }

      List<Bed> newBeds = [];
      bool addingBeds = true;
      
      while (addingBeds) {
        clearConsole();
        print('Current beds in room $roomNumber: ${newBeds.map((b) => b.id).join(', ')}');
        print('\nAdd a bed to room $roomNumber:');
        print('Enter bed ID (or "done" to finish, "back" to cancel room creation): ');
        String? bedId = stdin.readLineSync()?.trim();
        
        if (bedId == null || bedId.isEmpty) {
          print('Bed ID cannot be empty!');
          print('Press enter to continue...');
          stdin.readLineSync();
          continue;
        }
        
        if (bedId.toLowerCase() == 'back') {
          return;
        }
        
        if (bedId.toLowerCase() == 'done') {
          if (newBeds.isEmpty) {
            print('Room must have at least one bed!');
            print('Press enter to continue...');
            stdin.readLineSync();
            continue;
          }
          addingBeds = false;
          break;
        }

        if (newBeds.any((bed) => bed.id == bedId)) {
          print('Bed $bedId already exists in this room!');
          print('Press enter to continue...');
          stdin.readLineSync();
          continue;
        }

        var newBed = Bed(bedId, bedStatus.Available);
        newBeds.add(newBed);
        print('Bed $bedId added to room $roomNumber');
        print('Press enter to continue...');
        stdin.readLineSync();
      }

      var newRoom = Room(roomNumber, roomType, newBeds);
      rooms.add(newRoom);
      saveData();
      
      print('\nNew room created successfully!');
      print('Room: $roomNumber ($roomType)');
      print('Beds: ${newBeds.length} beds added');
      print('Press enter to continue...');
      stdin.readLineSync();
      return;
    }
  }

  Room? _findRoomForBed(Bed targetBed) {
    for (var room in rooms) {
      if (room.beds.contains(targetBed)) {
        return room;
      }
    }
    return null;
  }

  Patient _findPatientById(String id) {
    return patients.firstWhere(
      (patient) => patient.id == id,
      orElse: () => Patient('Unknown', 'Unknown Patient'),
    );
  }
}