// student_model.dart

class StudentModel {
  String? name;
  String? age;
  String? classs;
  String? image;

  StudentModel({this.name, this.age, this.classs, required this.image});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      image: json['image'],
      name: json['name'] as String?,
      age: json['age'] as String?,
      classs: json['class'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'age': age,
      'class': classs,
    };
  }
}
