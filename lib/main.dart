import 'package:digitalpendal/screens/Authentication/AuthPage.dart';
import 'package:digitalpendal/screens/Widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

final storage = FlutterSecureStorage();

class MyApp extends StatelessWidget {
  var value = storage.read(key: 'token');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue.shade900),
      debugShowCheckedModeBanner: false,
      home: (value != null) ? MyBottomNavigationBar() : AuthPage(),
    );
  }
}
