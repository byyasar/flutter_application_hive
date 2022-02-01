import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';

Widget buildCancelButton(BuildContext context) => myCustomMenuButton(
    context, () => Navigator.of(context).pop(), const Text('İptal'), IconsConstans.exitIcon, Colors.red);
/* TextButton(
      child: Row(
        children: [
          Icon(
            Icons.cancel,
            color: Colors.red.shade400,
          ),
          const Text('İptal', style: TextStyle(fontSize: 18.0)),
        ],
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
 */