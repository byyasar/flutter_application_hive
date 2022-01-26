import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> exitAppDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Eminmisiniz?'),
      content: const Text('Uygulama kapatılsın mı?'),
      actions: [
        ElevatedButton(
            onPressed: () {
              SystemNavigator.pop();
              exit(0);
            },
            child: const Text('Kapat')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('İptal')),
      ],
    ),
  );
}
