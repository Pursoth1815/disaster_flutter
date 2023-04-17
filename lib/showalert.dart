
import 'package:flutter/material.dart';

// user defined function
showAlertDialog(BuildContext context, String title, String message) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:  Text(message),
        actions: <Widget>[
          FlatButton(
            child:  Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            },
          ),
        ],
      );
    },
  );
}
