import 'package:digitalpendal/screens/Authentication/AuthPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Page extends StatefulWidget {
  @override
  _Profile_PageState createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {

  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text("Main Page")),

    );
  }
}
