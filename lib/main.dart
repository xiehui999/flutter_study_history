import 'package:flutter/material.dart';
import 'package:base_library/base_library.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = AppColors.app_main;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Text("111"),
      theme: ThemeData.light().copyWith(
        primaryColor: _themeColor,
        accentColor: _themeColor,
        indicatorColor: Colors.white,
      ),
    );
  }
}
