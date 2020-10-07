import 'dart:convert';
import 'package:digitalpendal/constants.dart';
import 'package:digitalpendal/screens/Widgets/NavBar.dart';
import 'package:digitalpendal/screens/Widgets/inputsW.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:digitalpendal/screens/Authentication/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;

  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);

  final formKey = new GlobalKey<FormState>();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Логин",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      style: _sizeTextBlack,
                      onSaved: (val) => _email = val,
                      validator: (val) =>
                          !val.contains("@") ? 'Not a valid email.' : null,
                    ),
                    width: 340.0,
                    height: 50,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 25.0)),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Пароль",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) =>
                          val.length < 2 ? 'Password too short.' : null,
                      onSaved: (val) => _password = val,
                      style: _sizeTextBlack,
                    ),
                    width: 340.0,
                    height: 50,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: submit,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Войти",
                        style: _sizeTextWhite,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: submitForm,
                      color: Colors.white,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Зарегистрироваться",
                        style: _sizeTextBlack,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      signIn();
    }
  }

  void login() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      submitForm();
    }
  }

  signIn() async {
    final storage = new FlutterSecureStorage();
    Map data = {'email': _email, 'password': _password};
    var jsonResponse;
    var response = await http.post(url + '/Auth.php', body: data);
    print(response);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {});
        await storage.write(key: "token", value: jsonResponse['token']);
        Navigator.of(_context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => MyBottomNavigationBar()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {});
      print(response.body);
    }
    httpGet();
  }

  httpGet() async {
    http.Response response = await http.get(Uri.encodeFull(url + '/Auth.php'),
        headers: {'Accept': 'application/json'});
    print("responce status: ${response.statusCode}");
    print("responce body: ${response.body}");
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void fucktheAuth() {
    hideKeyboard();
    Navigator.push(
        _context,
        new MaterialPageRoute(
            builder: (context) => new MyBottomNavigationBar()));
  }

  void submitForm() {
    hideKeyboard();
    Navigator.push(_context,
        new MaterialPageRoute(builder: (context) => new RegistrationPage()));
  }
}
