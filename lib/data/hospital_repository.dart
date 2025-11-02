import '../domain/room.dart';
import '../domain/patient.dart';

class HospitalRepository {
  final List<Room> _rooms = [];
  final List<Patient> _patients = [];

  List<Room> get rooms => List.unmodifiable(_rooms);
  List<Patient> get patients => List.unmodifiable(_patients);

  void addRoom(Room room) => _rooms.add(room);
  void addPatient(Patient patient) => _patients.add(patient);

  Room? findRoomByNumber(String number) {
    return _rooms.cast<Room?>().firstWhere(
      (r) => r!.number == number,
      orElse: () => null,
    );
  }

  List<Room> getRoomsWithAvailableBeds() {
    return _rooms.where((r) => r.availableBeds.isNotEmpty).toList();
  }
}