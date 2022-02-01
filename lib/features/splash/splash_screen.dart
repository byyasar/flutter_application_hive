import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/image_constants.dart';
import 'package:flutter_application_hive/features/sonuclar/view/sonuclar_select_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async{
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SonuclarSelectPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageConstants.logo);
  }
}
