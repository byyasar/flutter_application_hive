import 'package:flutter/material.dart';

Widget buildOkButton(BuildContext context, VoidCallback onPressed) =>
    TextButton(
      child: Row(
        children: [
          Icon(
            Icons.subdirectory_arrow_left,
            color: Colors.red.shade400,
          ),
          const Text('Tamam', style: TextStyle(fontSize: 18.0)),
        ],
      ),
      onPressed: onPressed,
    );
