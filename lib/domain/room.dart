import 'bed.dart';
import 'patient.dart';

// AI generated
enum RoomType { GENERAL, ICU, PEDIATRIC, SURGERY }

class Room {
  final String number;
  final RoomType type;
  final List<Bed> _beds = [];

  Room(this.number, this.type, int bedCount) {
    for (int i = 1; i <= bedCount; i++) {
      _beds.add(Bed('$number-B$i'));
    }
  }

  List<Bed> get beds => List.unmodifiable(_beds);
  List<Bed> get availableBeds => _beds.where((b) => b.isAvailable).toList();

  Bed? findAvailableBed() =>
      availableBeds.isNotEmpty ? availableBeds.first : null;

  bool assignPatientToAvailableBed(Patient patient) {
    final bed = findAvailableBed();
    if (bed == null) return false;
    bed.assignPatient(patient);
    return true;
  }

  @override
  String toString() {
    return 'Room($number, $type, Beds: ${beds.length}, Available: ${availableBeds.length})';
  }
}