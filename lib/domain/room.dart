import 'bed.dart';

class Room{
  String number;
  String types;
  List<Bed> beds;

  Room(this.number,this.types,this.beds);

  void addBed(Bed newBed){
    beds.add(newBed);
    print('Added ${newBed.id} to room $number');
  }

  //AI help with synax
  //Find beds that are available
  List<Bed> getAvailableBeds(){
    return beds.where((bed) => bed.status == bedStatus.Available).toList();
  }

  List<Bed> getOccupiedBeds(){
    return beds.where((bed) => bed.status == bedStatus.Occupied).toList();
  }

  //Find beds that are under maintenance
  List<Bed> getUnderMaintenance(){
    return beds.where((bed) => bed.status == bedStatus.Maintenance).toList();
  }

  int countAvailableBeds(){
    return getAvailableBeds().length;
  }

  int countOccupiedBeds(){
    return getOccupiedBeds().length;
  }

  int countUnderMaintenanceBeds(){
    return getUnderMaintenance().length;
  }

  void displayInfo(){
    print('Room $number ($types):');
    for(var bed in beds){
      String status = '';
      switch (bed.status){
        case bedStatus.Available:
        status = 'Available';
        break;
        case bedStatus.Occupied:
        status = 'Occupied';
        break;
        case bedStatus.Maintenance:
        status = 'Under Maintenance';
        break;
      }
      print(' - Bed ${bed.id}: $status');
    }
    print('Avaible Beds: ${countAvailableBeds()}');
    print('Bed is occupied: ${countOccupiedBeds()}');
    print('Bed under maintenance: ${countUnderMaintenanceBeds()}');
  }

  //find specific bed

  Bed? findBed(String bedId){
    try{
      return beds.firstWhere((bed) => bed.id == bedId);
    }catch (e){
      throw Exception("bed doesn't exist");
    }
  }
}