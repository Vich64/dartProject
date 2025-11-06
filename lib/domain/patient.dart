class Patient {
  String id;
  String name;

  Patient(this.id,this.name);

  void displayInfo(){
    print('Patient $id: $name');
  }

  //AI generated code
  //store data in json
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'name':name,
    };
  }

  factory Patient.fromJson(Map<String,dynamic> json){
    return Patient(
      json['id'],
      json['name'],
    );
  }
}