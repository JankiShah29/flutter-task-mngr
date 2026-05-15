import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {

  String taskId;
  final String title;   
  final String desc; 
  final DateTime date;
  final bool isCompleted;

  TaskModel({
    this.taskId = '',
    required this.title,
    required this.desc,
    required this.date,
    this.isCompleted = false,
  }); 

  factory TaskModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TaskModelToJson(this);
}