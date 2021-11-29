import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: HiveConstants.todoTypeId)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String detail;
  @HiveField(2)
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.detail,
    required this.isCompleted,
  });
}
