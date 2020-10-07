import 'package:digitalpendal/screens/TimelinePage/TaskPage.dart';
import 'package:digitalpendal/screens/Authentication/AuthPage.dart';
import 'package:digitalpendal/screens/Create_page/CreatePage.dart';
import 'package:digitalpendal/screens/Profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue.shade900),
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

