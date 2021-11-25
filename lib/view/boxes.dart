import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<TaskModel> getTransactions() =>
      Hive.box<TaskModel>(ApplicationConstants.TASKBOX_NAME);
}
