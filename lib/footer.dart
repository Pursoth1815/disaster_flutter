import 'package:flutter/material.dart';

BottomAppBar footerBar(BuildContext context) {
  return BottomAppBar(
      child: Container(
          height: 60.0,
          color: Theme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 8.0),
                child: Text(
                  "Govt of Tamil Nadu",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            Padding(
                padding: EdgeInsets.only(bottom: 5.0, right: 8.0),
              child: Text(
                "NIC Perambalur",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ],
          )));
}
