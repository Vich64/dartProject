import 'bed.dart';

class Patient {
  final String id;
  final String name;
  final DateTime admissionDate;
  Bed? _assignedBed;

  Patient(this.id, this.name, this.admissionDate);

  Bed? get assignedBed => _assignedBed;

  void assignToBed(Bed bed) {
    if (_assignedBed != null) {
      throw Exception('Patient $name already assigned to a bed');
    }
    _assignedBed = bed;
  }

  void discharge() => _assignedBed = null;

  @override
  String toString() {
    return 'Patient($id, $name, Bed: ${_assignedBed?.id ?? "None"})';
  }
}