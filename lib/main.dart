import 'package:flutter/material.dart';
import 'package:flutter_application_hive/features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Hive Expense App';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        //theme: ThemeData(primarySwatch: Colors.indigo),
        theme: ThemeData.dark(),
        //home: MainpageView(),//OgrencipageView
        //home: const OgrencipageView(), //OgrencipageView
        home: const SplashScreen(), //OgrencipageView
        //home: const SinifpageView(), //OgrencipageViewTemrinnotpageView
        // home: const TemrinnotpageView(),
      );
}
