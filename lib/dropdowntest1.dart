/* import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
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

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<String> transactions = [];
  String dropdownValue = "";

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    transactions = SinifBoxes.getTransactions()
        .values
        .map((e) => e.sinifAd.toString())
        .toList();
    //SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    // ignore: avoid_print
    print(transactions);
    dropdownValue = transactions.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: transactions.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
 */