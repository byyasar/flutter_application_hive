import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/view/mainpage_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(OgrenciModelAdapter());
  await Hive.openBox<TaskModel>(ApplicationConstants.TASKBOX_NAME);
  await Hive.openBox<OgrenciModel>(ApplicationConstants.BOX_OGRENCI);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Hive Expense App';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.indigo),
        //home: MainpageView(),//OgrencipageView
        home:const OgrencipageView(),//OgrencipageView
      );
}