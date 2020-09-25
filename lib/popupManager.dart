import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopupManager{
  Widget PopUp<T>(Future method, Widget popup){
    return Scaffold(
        body: Container(
          child: FutureBuilder<T>(
          future: method,
          builder: (context, projectSnap) {
            return projectSnap.connectionState == ConnectionState.done
                ? AlertDialog(
                  content: popup
                )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        )));
  }
}