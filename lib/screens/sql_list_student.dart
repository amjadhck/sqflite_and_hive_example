import 'package:flutter/material.dart';
import 'package:sqflite_and_hive_projects/functions/db_functions.dart';
import 'package:sqflite_and_hive_projects/model/data_model.dart';
import 'package:sqflite_and_hive_projects/screens/edit_student.dart';

class SQLListStudents extends StatefulWidget {
  @override
  _SQLListStudentsState createState() => _SQLListStudentsState();
}

class _SQLListStudentsState extends State<SQLListStudents> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifierSQL,
      builder: (context, List<StudentModel> studentList, child) {
        return ListView.separated(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          itemBuilder: (context, index) {
            final data = studentList[index];
            return ListTile(
              tileColor: Colors.blueAccent,
              leading: Text(data.id.toString()),
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
                                    EditStudent(studentList[index], context, 1),
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
                        deleteStudentSql(data.id);
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
