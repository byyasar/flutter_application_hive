import 'package:flutter/material.dart';

Widget myCustomMenuButton(BuildContext context, VoidCallback voidCallback,
    String btnText, Icon btnIcon) {
  return ElevatedButton(
    onPressed: voidCallback,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [btnIcon, const SizedBox(width: 10), Text(btnText)],
    ),
  );
}
