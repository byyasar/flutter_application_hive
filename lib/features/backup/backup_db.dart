import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/widget/build_drawer.dart';
import 'package:flutter_application_hive/core/widget/custom_appbar.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupDb extends StatefulWidget {
  const BackupDb({Key? key}) : super(key: key);

  @override
  _BackupDbState createState() => _BackupDbState();
}

class _BackupDbState extends BaseState<BackupDb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Database İşlemleri'),
      drawer: buildDrawer(context),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          myCustomMenuButton(context, createBackup, const Text('Yedekle'), const Icon(Icons.backup), Colors.amber),
          myCustomMenuButton(context, restoreBackup, const Text('Geri Al'), const Icon(Icons.backup), Colors.amber),
        ],
      )),
    );
  }

/*  await Hive.openBox<SinifModel>(ApplicationConstants.boxSinif); */
  Future<void> createBackup() async {
    print('yedek alınıyor');
    if (Hive.box<OgrenciModel>(ApplicationConstants.boxOgrenci).isEmpty) {
      print('db bulunamadı');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Products Stored.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Creating backup...')),
    );

    Map<String, dynamic> map = Hive.box<OgrenciModel>(ApplicationConstants.boxOgrenci).toMap().map((key, value) =>
        MapEntry(key.toString(),
            'id:${value.id}, ogrenciName: ${value.name}, ogrenciNu: ${value.nu}, sinifId: ${value.sinifId}'));

    String json = jsonEncode(map);

    await Permission.storage.request();

    Directory dir = await _getDirectory();
    String formattedDate = DateTime.now().toString().replaceAll('.', '-').replaceAll(' ', '-').replaceAll(':', '-');
    String path =
        '${dir.path}$formattedDate.json'; //Change .json to your desired file format(like .barbackup or .hive).
    File backupFile = File(path);
    await backupFile.writeAsString(json);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Backup saved in folder Barcodes')),
    );
  }

  Future<Directory> _getDirectory() async {
    const String pathExt = 'Barcodes/'; //This is the name of the folder where the backup is stored
    Directory newDirectory = Directory(
        '/storage/emulated/0/' + pathExt); //Change this to any desired location where the folder will be created
    if (await newDirectory.exists() == false) {
      return newDirectory.create(recursive: true);
    }
    return newDirectory;
  }

  Future<void> restoreBackup() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restoring backup...')),
    );
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (file != null) {
      File files = File(file.files.single.path.toString());
      Hive.box<OgrenciModel>(ApplicationConstants.boxOgrenci).clear();
      Map<String, dynamic> map = jsonDecode(await files.readAsString());
      map.forEach((key, value) {
        print(value);
        OgrenciModel product = OgrenciModel.fromJson(value);
        Hive.box<OgrenciModel>(ApplicationConstants.boxOgrenci).add(product);
      });
      /*  for (var i = 0; i < map.length; i++) {
        print(map[i]);
        OgrenciModel product = OgrenciModel.fromJson(map[]);
        Hive.box<OgrenciModel>(ApplicationConstants.boxOgrenci).add(product);
      } */
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restored Successfully...')),
      );
    }
  }
}
