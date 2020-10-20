import 'dart:convert';

import 'package:digitalpendal/screens/Widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import 'RegistrationPage.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}
class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool visible = true;
  String email, password;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width, child: _linkSignUp()),
      body: Form(key: _key, autovalidate: _validate, child: _body(context)),
    );
  }
  _body(BuildContext context) =>
      ListView(physics: BouncingScrollPhysics(), children: <Widget>[
        Container(
            padding: EdgeInsets.all(15),
            child: Column(
                children: <Widget>[_formUI(), _socialSignIn(),]))
      ]);
  @override
  void dispose() {
    if (this.mounted) super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _formUI() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40.0),
          _inputEmail(),
          SizedBox(height: 12.0),
          _inputPassword(),
          SizedBox(height: 20.0),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                splashColor: Colors.black26,
                elevation: 0,
                highlightElevation: 0,
                padding: const EdgeInsets.all(15.0),
                child: Text("Войти".toUpperCase()),
                onPressed: () {
                  _sendToServer();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              )),
          _linkForgotPassword()
        ],
      ),
    );
  }
  _inputEmail() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Email',
        prefixIcon: _prefixIcon(Icons.email),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (str) {
        email = str;
      },
    );
  }
  _inputPassword() {
    return TextFormField(
        controller: _passwordController,
        obscureText: visible,
        validator: validatePassword,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            hintText: 'Password',
            prefixIcon: _prefixIcon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            suffix: InkWell(
              child: visible
                  ? Icon(
                Icons.visibility_off,
                size: 18,
                color: Colors.black26,
              )
                  : Icon(
                Icons.visibility,
                size: 18,
                color: Colors.black26,
              ),
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
            )),
        onSaved: (str) {
          password = str;
        });
  }
  _prefixIcon(IconData iconData) {
    return Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(10.0))),
        child: Icon(
          iconData,
          size: 20,
          color: Colors.grey,
        ));
  }
  _linkForgotPassword() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
                child: Text('Забыли пароль?',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                onPressed: () {

                }
            )
          ]
      )
    ]);
  }
  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      signIn();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
  signIn() async {
    final storage =  FlutterSecureStorage();
    Map data = {'email': email, 'password': password};
    var jsonResponse;
    var response = await http.post(url + '/Auth.php', body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {});
        await storage.write(key: "token", value: jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => MyBottomNavigationBar()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {});
      print(response.body);
    }
  }
  _linkSignUp() => Padding(
    padding: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Не имеете аккаунта?',
            style: TextStyle(color: Colors.grey)),
        FlatButton(
          child: Text('Создать аккаунт',
              style: TextStyle(
                  color: Colors.black87,
                  //decoration: TextDecoration.underline,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
          onPressed: () {
            Reg();
          },
        ),
      ],
    ),
  );
  void Reg() {
    Navigator.push(context,
         MaterialPageRoute(builder: (context) =>  RegistrationPage()));
  }
}
  _socialSignIn() {
    return Container(
        child: Column(children: <Widget>[
          SizedBox(height: 40.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.black12,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              width: 100.0,
              height: 1.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  "или",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black12,
                      Colors.grey,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              width: 100.0,
              height: 1.0,
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(0.0),
                child: RaisedButton(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    highlightElevation: 0.0,
                    onPressed: () {},
                    splashColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      size: 20,
                      color: Colors.blueAccent,
                    )),
              ),
              Container(
                margin: EdgeInsets.all(0.0),
                child: RaisedButton(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    highlightElevation: 0.0,
                    onPressed: () {},
                    splashColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                    child: Icon(
                      FontAwesomeIcons.google,
                      size: 20,
                      color: Colors.red,
                    )),
              ),
            ],
          )
        ]));
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Email не может быть пустым';
    } else if (!regExp.hasMatch(value)) {
      return 'Некорректный email';
    } else {
      return null;
    }
  }
  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password не может быть пустым';
    } else if (value.length < 4) {
      return 'Password не может содержать меньше 4 символов';
    }
    return null;
  }
