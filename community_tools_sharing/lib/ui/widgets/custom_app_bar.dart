import 'package:flutter/material.dart';

AppBar builAppBar(BuildContext context, {required String title, bool? showBackButton}) {
  return AppBar(
    backgroundColor: Color(0xffF7FAFC),
    title: Text(title, style: TextStyle(color: Colors.black)),
    centerTitle: true,
    leading: showBackButton == true
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          )
        : null,
  );
}
