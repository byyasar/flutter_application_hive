import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';
//import 'package:flutter_application_hive/dersler/view/ders_view.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/siniflar/view/sinif_view.dart';
//import 'package:flutter_application_hive/ogrenci/view/ogrenci_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(OgrenciModelAdapter());
  Hive.registerAdapter(DersModelAdapter());
  Hive.registerAdapter(SinifModelAdapter());
  await Hive.openBox<TaskModel>(ApplicationConstants.taskBoxName);
  await Hive.openBox<OgrenciModel>(ApplicationConstants.boxOgrenci);
  await Hive.openBox<DersModel>(ApplicationConstants.boxDers);
  await Hive.openBox<SinifModel>(ApplicationConstants.boxSinif);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Hive Expense App';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.indigo),
        //home: MainpageView(),//OgrencipageView
        //home: const OgrencipageView(), //OgrencipageView
        //home: const DerspageView(), //OgrencipageView
        home: const SinifpageView(), //OgrencipageView
      );
}
