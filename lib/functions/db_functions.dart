import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_and_hive_projects/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifierHive = ValueNotifier([]);
ValueNotifier<List<StudentModel>> studentListNotifierSQL = ValueNotifier([]);

late Database _db;

Future<void> initializeDataBase() async {
  _db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
    },
  );
}

Future<void> addStudentBoth(StudentModel value) async {
  addStudentHive(value);
  addStudentSql(value);
}

Future<void> addStudentSql(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student (name,age) VALUES (?,?)', [value.name, value.age]);
  studentListNotifierSQL.value.add(value);
  studentListNotifierSQL.notifyListeners();
  getAllStudent();
}

Future<void> addStudentHive(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  await studentDB.add(value);
  studentListNotifierHive.value.add(value);
  studentListNotifierHive.notifyListeners();
  getAllStudent();
}

Future<void> getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  studentListNotifierHive.value.clear();
  studentListNotifierHive.value.addAll(studentDB.values);
  studentListNotifierHive.notifyListeners();
  final _values = await _db.rawQuery('SELECT * FROM student');
  //sqlgetall
  studentListNotifierSQL.value.clear();
  _values.forEach((element) {
    final student = StudentModel.fromMap(element);
    studentListNotifierSQL.value.add(student);
  });
  studentListNotifierSQL.notifyListeners();
}

Future<void> deleteStudentHive(int id) async {
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  await studentDB.deleteAt(id);
  getAllStudent();
}

Future<void> deleteStudentSql(int? id) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
  getAllStudent();
}

Future<void> updateStudentHive(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>("student_db");
  studentDB.put(id, value);
  getAllStudent();
}

Future<void> updateStudentSql(StudentModel model) async {
  await _db.rawUpdate('UPDATE student SET name = ?, age = ? WHERE id = ?',
      [model.name, model.age, model.id]);
  getAllStudent();
}
