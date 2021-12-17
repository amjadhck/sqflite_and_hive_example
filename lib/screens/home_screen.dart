import 'package:flutter/material.dart';
import 'package:sqflite_and_hive_projects/functions/db_functions.dart';
import 'package:sqflite_and_hive_projects/screens/add_student.dart';
import 'package:sqflite_and_hive_projects/screens/hive_list_student.dart';
import 'package:sqflite_and_hive_projects/screens/sql_list_student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    //getAllStudents();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.data_usage), label: "Hive"),
          BottomNavigationBarItem(icon: Icon(Icons.data_usage), label: "Sql"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: const Text("Hive"),
      ),
      body: Column(
        children: [
          AddStudent(),
          if (_selectedIndex == 0)
            const Expanded(child: HiveListStudent())
          else
            Expanded(child: SQLListStudents())
        ],
      ),
    );
  }
}
