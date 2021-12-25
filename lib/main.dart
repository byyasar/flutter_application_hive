import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:flutter_application_hive/features/temrinnot/view/temrinnot_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OgrenciModelAdapter());
  Hive.registerAdapter(DersModelAdapter());
  Hive.registerAdapter(SinifModelAdapter());
  Hive.registerAdapter(TemrinModelAdapter());
  Hive.registerAdapter(TemrinnotModelAdapter());
  await Hive.openBox<OgrenciModel>(ApplicationConstants.boxOgrenci);
  await Hive.openBox<DersModel>(ApplicationConstants.boxDers);
  await Hive.openBox<SinifModel>(ApplicationConstants.boxSinif);
  await Hive.openBox<TemrinModel>(ApplicationConstants.boxTemrin);
  await Hive.openBox<TemrinnotModel>(ApplicationConstants.boxTemrinNot);

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
        //home: const MainPage(), //OgrencipageView
        //home: const SinifpageView(), //OgrencipageViewTemrinnotpageView
        home: const TemrinnotpageView(),
      );
}
