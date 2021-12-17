import 'package:hive_flutter/hive_flutter.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  StudentModel({required this.name, required this.age, this.id});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;

    return StudentModel(id: id, name: name, age: age);
  }

  @override
  String toString() {
    return 'StudentModel{name: $name, age: $age}';
  }
}
