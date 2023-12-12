import 'package:flutter/material.dart';

class InfoApp extends StatelessWidget {
  static const String routeName = '/infoApp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("infoApp"),
      ),
      body: Center(
        child: Text(
          'infoApp Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
