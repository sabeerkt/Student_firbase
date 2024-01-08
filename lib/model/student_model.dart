// student_model.dart

class StudentModel {
  String? name;
  String? age;
  String? classs;

  StudentModel({this.name, this.age, this.classs});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'] as String?,
      age: json['age'] as String?,
      classs: json['class'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'class': classs,
    };
  }
}
