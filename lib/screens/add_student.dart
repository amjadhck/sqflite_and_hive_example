// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sqflite_and_hive_projects/functions/db_functions.dart';
import 'package:sqflite_and_hive_projects/model/data_model.dart';
import 'package:sqflite_and_hive_projects/screens/home_screen.dart';

enum Options { hive, sql, both }

class AddStudent extends StatefulWidget {
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  Options? _option = Options.hive;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Name"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Age"),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hive :"),
                Radio<Options>(
                  value: Options.hive,
                  groupValue: _option,
                  onChanged: (Options? value) {
                    setState(() {
                      _option = value;
                    });
                  },
                ),
                Text("SQL :"),
                Radio<Options>(
                  value: Options.sql,
                  groupValue: _option,
                  onChanged: (Options? value) {
                    setState(() {
                      _option = value;
                    });
                  },
                ),
                Text("Both :"),
                Radio<Options>(
                  value: Options.both,
                  groupValue: _option,
                  onChanged: (Options? value) {
                    setState(() {
                      _option = value;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              onPressed: () {
                onAddStudent();
              },
              label: Text("Add Student"),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudent() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    if (_name.isEmpty || _age.isEmpty) {
      return;
    }
    print("$_name $_age");

    final _student = StudentModel(name: _name, age: _age);
    if (_option == Options.hive) {
      //hive only
      addStudentHive(_student);
    } else if (_option == Options.sql) {
      // sql only
      addStudentSql(_student);
    } else {
      //both
      addStudentBoth(_student);
    }
    //getAllStudent();
    _nameController.clear();
    _ageController.clear();
  }
}
