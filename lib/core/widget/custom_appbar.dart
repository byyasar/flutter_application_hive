import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/core/widget/exitapp_dialog.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        onPressed: () {
          exitAppDialog(context);
        },
        icon: IconsConstans.exitIcon,
      )
    ],
  );
}
