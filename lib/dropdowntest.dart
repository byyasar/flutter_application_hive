import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/siniflar/store/sinif_store.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
  final SinifStore sinifStore = SinifStore();
  List<SinifModel> transactions = [];
  List<String> transactionssinif = [];
  String dropdownValue = "";
  int selectedId = 1;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    transactionssinif = SinifBoxes.getTransactions()
        .values
        .map((e) => e.sinifAd.toString())
        .toList();
    transactions =
        SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    // ignore: avoid_print
    print(transactions);
    dropdownValue = transactions.first.sinifAd;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 160,
          child: DropdownSearch<String>(
              mode: Mode.MENU,
              // showSelectedItem: true,
              items: transactionssinif,
              // ignore: deprecated_member_use
              label: "Sınıflar",
              // ignore: deprecated_member_use
              hint: "country in menu mode",
              //popupItemDisabled: (String s) => s.startsWith('B'),
              //onChanged: (value) => print('seçilen $value'),
              selectedItem: transactionssinif.first),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OgrencipageView()),
            );
          },
          child: const Text('Git'),
        )
      ],
    );
  }
}
