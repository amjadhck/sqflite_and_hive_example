import 'package:flutter/material.dart';
import 'package:sqflite_and_hive_projects/functions/db_functions.dart';
import 'package:sqflite_and_hive_projects/model/data_model.dart';
import 'package:sqflite_and_hive_projects/screens/edit_student.dart';

class HiveListStudent extends StatefulWidget {
  const HiveListStudent({Key? key}) : super(key: key);

  @override
  _HiveListStudentState createState() => _HiveListStudentState();
}

class _HiveListStudentState extends State<HiveListStudent> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifierHive,
      builder: (context, List<StudentModel> studentList, child) {
        return ListView.separated(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          itemBuilder: (context, index) {
            final data = studentList[index];
            return ListTile(
              tileColor: Colors.yellow,
              leading: Text(data.key.toString()),
              title: Text(data.name),
              subtitle: Text(data.age),
              trailing: SizedBox(
                height: 50,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return Dialog(
                                child:
                                    EditStudent(studentList[index], context, 0),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteStudentHive(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: studentList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }
}
