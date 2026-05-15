import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TaskModel {
   String docId; 
   String title;   
   String desc; 
   DateTime date;
   String status;

  TaskModel({
    required this.docId,
    required this.title,
    required this.desc,
    required this.date,
    required this.status,
  }); 

}