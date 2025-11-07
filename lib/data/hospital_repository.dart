import 'dart:convert';
import 'dart:io';
import '../domain/patient.dart';
import '../domain/room.dart';
import '../domain/bed.dart';


//AI generated code
class Repository {
  static const String dataDir = 'lib/data/';
  static const String patientsFile = '${dataDir}patients.json';
  static const String roomsFile = '${dataDir}rooms.json';

  Repository() {
    // Create data directory if it doesn't exist
    Directory(dataDir).createSync(recursive: true);

  }

  // Save patients to JSON file
  void savePatients(List<Patient> patients) {
    try {
      final file = File(patientsFile);
      final jsonList = patients.map((patient) => patient.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      file.writeAsStringSync(jsonString);
      print('Patients saved to $patientsFile');
    } catch (e) {
      print('Error saving patients: $e');
    }
  }

  // Load patients from JSON file
  List<Patient> loadPatients() {
    try {
      final file = File(patientsFile);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((json) => Patient.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading patients: $e');
    }
    return []; // Return empty list if file doesn't exist or error
  }

  // Save rooms to JSON file
  void saveRooms(List<Room> rooms) {
    try {
      final file = File(roomsFile);
      final roomsJson = rooms.map((room) => _roomToJson(room)).toList();
      final jsonString = jsonEncode(roomsJson);
      file.writeAsStringSync(jsonString);
      print('Rooms saved to $roomsFile');
    } catch (e) {
      print('Error saving rooms: $e');
    }
  }

  // Load rooms from JSON file
  List<Room> loadRooms() {
    try {
      final file = File(roomsFile);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((json) => _roomFromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading rooms: $e');
    }
    return [];
  }

  // Helper method to convert Room to JSON
  Map<String, dynamic> _roomToJson(Room room) {
    return {
      'number': room.number,
      'types': room.types,
      'beds': room.beds.map((bed) => _bedToJson(bed)).toList(),
    };
  }

  // Helper method to create Room from JSON
  Room _roomFromJson(Map<String, dynamic> json) {
    final beds = (json['beds'] as List)
        .map((bedJson) => _bedFromJson(bedJson))
        .toList();
    
    return Room(json['number'], json['types'], beds);
  }

  // Helper method to convert Bed to JSON
  Map<String, dynamic> _bedToJson(Bed bed) {
    return {
      'id': bed.id,
      'status': _bedStatusToString(bed.status),
      'patientId': bed.patientId,
    };
  }

  // Helper method to create Bed from JSON
  Bed _bedFromJson(Map<String, dynamic> json) {
    return Bed(
      json['id'],
      _stringToBedStatus(json['status']),
      json['patientId'],
    );
  }

  // Convert bedStatus enum to string
  String _bedStatusToString(bedStatus status) {
    switch (status) {
      case bedStatus.Available:
        return 'Available';
      case bedStatus.Occupied:
        return 'Occupied';
      case bedStatus.Maintenance:
        return 'Maintenance';
    }
  }

  // Convert string to bedStatus enum
  bedStatus _stringToBedStatus(String status) {
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