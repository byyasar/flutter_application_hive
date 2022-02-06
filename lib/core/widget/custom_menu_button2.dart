

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


Widget myCustomMenuButto2(
    BuildContext context, VoidCallback? voidCallback, String btnText, Icon btnIcon, Color? btnPrimary,double? genislik) {
  //final text = btnText.cast<Text>;
  btnPrimary ?? Colors.blue;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(primary: btnPrimary),
    onPressed: voidCallback,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [btnIcon, const SizedBox(width: 10), SizedBox(width: genislik,
        child: AutoSizeText(btnText, style: const TextStyle(fontSize: 18),
  minFontSize: 18,
  maxLines: 3,),
      )],
    ),
  );
}