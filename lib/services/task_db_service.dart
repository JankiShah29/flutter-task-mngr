import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:interview_test/models/task_model.dart';

class TaskDbService {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<bool> createTask({
    required String title,
    required String description,
    required String status,
    required DateTime date,
    required VoidCallback onSuccess,
  }) async {
    try {
      final userId = auth.currentUser?.email;
      if (userId == null) {
        print('No user logged in');
        return false;
      }

      final response = await db
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add({
            // add
            'title': title,
            'description': description,
            'date': date,
            'status': status,
          });

      print(response.id);
      onSuccess();
      return true;

    } catch (e) {
      
      print('Error creating task: $e');
      return false;
    }
  }

  Future<List<TaskModel>> getTasks() async {
    final result = await db
        .collection('users')
        .doc(auth.currentUser?.email)
        .collection('tasks')
        .get();

    List<TaskModel> tasks = result.docs.map((doc) {
      return TaskModel.fromJson(doc.data());
    }).toList();

    return tasks;
  }
}
