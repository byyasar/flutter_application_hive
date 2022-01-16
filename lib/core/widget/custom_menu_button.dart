import 'package:flutter/material.dart';

Widget myCustomMenuButton(BuildContext context, VoidCallback? voidCallback, Widget btnText, Icon btnIcon) {
  //final text = btnText.cast<Text>;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18)),
    onPressed: voidCallback,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [btnIcon, const SizedBox(width: 10), btnText],
    ),
  );
}
