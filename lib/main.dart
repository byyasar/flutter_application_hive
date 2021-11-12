import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/view/mainpage_view.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(ApplicationConstants.TASKBOX_NAME);
  runApp(const MainpageView());
}


