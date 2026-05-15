// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  taskId: json['taskId'] as String,
  title: json['title'] as String,
  desc: json['desc'] as String,
  date: DateTime.parse(json['date'] as String),
  isCompleted: json['isCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'taskId': instance.taskId,
  'title': instance.title,
  'desc': instance.desc,
  'date': instance.date.toIso8601String(),
  'isCompleted': instance.isCompleted,
};
