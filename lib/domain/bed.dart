import 'patient.dart';

// AI generated
enum BedStatus { AVAILABLE, OCCUPIED, MAINTENANCE }

class Bed {
  final String id;
  BedStatus _status;
  Patient? _patient;

  Bed(this.id)
      : _status = BedStatus.AVAILABLE,
        _patient = null;

  BedStatus get status => _status;
  Patient? get patient => _patient;
  bool get isAvailable => _status == BedStatus.AVAILABLE;

  void assignPatient(Patient patient) {
    if (_status != BedStatus.AVAILABLE) {
      throw Exception('Bed $id is not available');
    }
    _patient = patient;
    _status = BedStatus.OCCUPIED;
    patient.assignToBed(this);
  }

  void release() {
    if (_patient != null) _patient!.discharge();
    _patient = null;
    _status = BedStatus.AVAILABLE;
  }

  void setMaintenance() {
    if (_status == BedStatus.OCCUPIED) {
      throw Exception('Cannot set occupied bed to maintenance');
    }
    _status = BedStatus.MAINTENANCE;
  }

  @override
  String toString() {
    return 'Bed($id, $status, Patient: ${_patient?.name ?? "None"})';
  }
}