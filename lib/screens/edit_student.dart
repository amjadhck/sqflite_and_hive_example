// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sqflite_and_hive_projects/functions/db_functions.dart';
import 'package:sqflite_and_hive_projects/model/data_model.dart';

class EditStudent extends StatelessWidget {
  final StudentModel stud;
  final BuildContext ctx1;
  final int selectedindex;
  EditStudent(this.stud, this.ctx1, this.selectedindex);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _nameController.text = stud.name;
    _ageController.text = stud.age;

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextFormField(
            //initialValue: name,
            controller: _nameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Name"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            //initialValue: age,
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Age"),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            onPressed: () {
              onEditStudent(ctx1, selectedindex);
            },
            label: const Text("Edit Student"),
          )
        ],
      ),
    );
  }

  Future<void> onEditStudent(BuildContext ctx2, int selectedIndex) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _key = stud.key;
    if (_name.isEmpty || _age.isEmpty) {
      return;
    }
    print(stud);
    final _student = StudentModel(name: _name, age: _age);
    final _studentsql = StudentModel(name: _name, age: _age, id: stud.id);
    if (selectedindex == 0) {
      updateStudentHive(_key, _student);
    } else if (selectedindex == 1) {
      updateStudentSql(_studentsql);
    }
    //updateStudent(_key, _student);
    Navigator.of(ctx2).pop();
  }
}
