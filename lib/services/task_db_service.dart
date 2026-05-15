import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:interview_test/models/task_model.dart';

class TaskDbService {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<String> createTask({
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
        return '';
      }

      final response = await db
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add({
            'title': title,
            'description': description,
            'date': date,
            'status': status,
          });

      onSuccess();
      return response.id;
    } catch (e) {
      print('Error creating task: $e');
      return '';
    }
  }

  Future<List<TaskModel>> fetchTasks() async {
    print('email : ${auth.currentUser?.email}');

    final result = await db
        .collection('users')
        .doc(auth.currentUser?.email)
        .collection('tasks')
        .get();

    List<TaskModel> tasks = result.docs.map((d) {
      final data = d.data();
      return TaskModel(
        docId: d.id,
        title: data["title"],
        desc: data["description"],
        date: (data["date"] as Timestamp).toDate(),
        status: data["status"],
      );
    }).toList();

    return tasks;
  }

  Future<TaskModel?> getTaskById(String docId) async {
    try {
      final result = await db
          .collection("users")
          .doc(auth.currentUser?.email)
          .collection("tasks")
          .doc(docId)
          .get();

      if (result.exists) {
        final data = result.data() as Map<String, dynamic>;

        final obj = TaskModel(
          docId: docId,
          title: data["title"],
          desc: data["description"],
          date: (data["date"] as Timestamp).toDate(),
          status: data["status"],
        );

        return obj;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTask(String docId) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser?.email)
          .collection("tasks")
          .doc(docId)
          .delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateStatus(String docId, String status) async {
    try {
      await db
          .collection("users")
          .doc(auth.currentUser?.email)
          .collection("tasks")
          .doc(docId)
          .update({"status": status});

      return true;
    } catch (e) {
      return false;
    }
  }
}
