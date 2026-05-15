import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TaskModel {
  final String docId; 
  final String title;   
  final String desc; 
  final DateTime date;
  final String status;

  TaskModel({
    required this.docId,
    required this.title,
    required this.desc,
    required this.date,
    required this.status,
  }); 

}