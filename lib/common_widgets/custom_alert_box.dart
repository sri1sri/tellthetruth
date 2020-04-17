import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomAlertBox(BuildContext context, String title, String desctiption,  VoidCallback onPressed){
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(desctiption),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: onPressed,
          ),
        ],
      );
    },
  );
}