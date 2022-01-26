import 'package:flutter/material.dart';

Future<bool> customDialogFunc(
    BuildContext context, String title, String content, String okText, String cancelText) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(okText)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(cancelText)),
            ],
          ));
}

Future<Widget> customDialogInfo(BuildContext context, String title, String content, String okText) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(okText)),
            ],
          ));
}
