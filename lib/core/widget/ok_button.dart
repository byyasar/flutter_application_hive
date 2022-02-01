import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';

Widget buildOkButton(BuildContext context, VoidCallback onPressed) =>
    myCustomMenuButton(context, onPressed, const Text('Tamam'), IconsConstans.okIcon, Colors.green);
