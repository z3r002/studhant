import 'package:digitalpendal/screens/Authentication/AuthPage.dart';
import 'package:digitalpendal/screens/Create_page/CreatePage.dart';
import 'package:digitalpendal/screens/ProfilePage/ProfilePage.dart';
import 'package:digitalpendal/screens/ProfilePage/ProfilePage.dart';
import 'package:digitalpendal/screens/ProfilePage/ProfilePage.dart';
import 'package:digitalpendal/screens/TimelinePage/TaskPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    String value = await storage.read(key: 'token');
    if (value == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => AuthPage()),
          (Route<dynamic> route) => false);
    }
  }

  int _currentIndex = 0;
  final List<Widget> _children = [TaskPage(), CreatePage(), Profile()];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  size: 30,
                  color: Colors.black,
                ),
                title: Text(''),
                activeIcon: Icon(
                  Icons.dashboard,
                  size: 30,
                  color: Colors.cyan,
                )),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 30,
                color: Colors.black,
              ),
              title: Text(''),
              activeIcon: Icon(Icons.add_circle, size: 30, color: Colors.cyan),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30, color: Colors.black),
                title: Text(''),
                activeIcon: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.cyan,
                )),
          ],
        ));
  }
}
