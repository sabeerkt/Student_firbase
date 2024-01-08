class StudentModel {
  String? name;
  int? age;
  int? classs;
  StudentModel({this.name, this.age, this.classs});
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      age: json['roll no'],
      classs: json['class'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'roll no': age,
      'class': classs,
    };
  }
}
