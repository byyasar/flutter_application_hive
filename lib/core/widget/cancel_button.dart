import 'package:flutter/material.dart';

Widget buildCancelButton(BuildContext context) => TextButton(
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
