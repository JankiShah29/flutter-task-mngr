import 'package:flutter/material.dart';
import 'package:interview_test/models/task_model.dart';
import 'package:interview_test/screens/create_task.dart';
import 'package:interview_test/services/task_db_service.dart';

enum TaskStatus {
  pending,
  completed,
  inProgress
}

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasksList = await TaskDbService().getTasks();
    setState(() {
      tasks = tasksList;
    });
    print('tasks: ${tasksList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Tasks List'),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTask()));
        },
        child: Icon(Icons.add),
      ),

    );
  }
}