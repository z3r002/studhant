// import 'package:digitalpendal/constants.dart';
// import 'package:digitalpendal/screens/Widgets/NavBar.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'AuthPage.dart';
//
// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }
//
// class _RegistrationPageState extends State<RegistrationPage> {
//   String _email;
//   String _password;
//   String _lastName;
//   String _firstName;
//   String _phone;
//   int id;
//   final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
//   final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
//   final _sizeTextGrey = const TextStyle(fontSize: 20.0, color: Colors.grey);
//
//   final formKey = new GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   BuildContext _context;
//
//   @override
//   Widget build(BuildContext context) {
//     _context = context;
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           resizeToAvoidBottomPadding: false,
//           body: Center(
//             child: SingleChildScrollView(
//               child: Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(padding: EdgeInsets.only(top: 20.0)),
//                       Container(
//                         child: TextFormField(
//                           //decoration: new InputDecoration(labelText: "Почта"),
//                           decoration: InputDecoration(
//                             labelText: "Почта",
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(),
//                             ),
//                             //fillColor: Colors.green
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                           maxLines: 1,
//                           style: _sizeTextBlack,
//                           onSaved: (val) => _email = val,
//                           validator: (val) =>
//                               !val.contains("@") ? 'Некорректный email' : null,
//                         ),
//                         width: 340.0,
//                         height: 50,
//                       ),
//                       Container(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Пароль",
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(),
//                             ),
//                             //fillColor: Colors.green
//                           ),
//                           obscureText: true,
//                           maxLines: 1,
//                           validator: (val) => val.length < 6
//                               ? 'Пароль меньше 6 символов.'
//                               : null,
//                           onSaved: (val) => _password = val,
//                           style: _sizeTextBlack,
//                         ),
//                         width: 340.0,
//                         height: 50,
//                         margin: EdgeInsets.only(top: 20.0),
//                       ),
//                       Container(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Фамилия",
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(),
//                             ),
//                             //fillColor: Colors.green
//                           ),
//                           maxLines: 1,
//                           validator: (val) =>
//                               val.length < 2 ? 'Введите фамилию' : null,
//                           onSaved: (val) => _lastName = val,
//                           style: _sizeTextBlack,
//                         ),
//                         width: 340.0,
//                         height: 50,
//                         margin: EdgeInsets.only(top: 20.0),
//                       ),
//                       Container(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Имя",
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(),
//                             ),
//                             //fillColor: Colors.green
//                           ),
//                           maxLines: 1,
//                           validator: (val) =>
//                               val.length < 2 ? 'Введите имя' : null,
//                           onSaved: (val) => _firstName = val,
//                           style: _sizeTextBlack,
//                         ),
//                         width: 340.0,
//                         height: 50,
//                         margin: EdgeInsets.only(top: 20.0),
//                       ),
//
//                       Container(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Телефон",
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25.0),
//                               borderSide: BorderSide(),
//                             ),
//                             //fillColor: Colors.green
//                           ),
//                           maxLines: 1,
//                           validator: (val) =>
//                               val.length < 2 ? 'Введите телефон' : null,
//                           onSaved: (val) => _phone = val,
//                           style: _sizeTextBlack,
//                         ),
//                         width: 340.0,
//                         height: 50,
//                         margin: EdgeInsets.only(top: 20.0),
//                       ),
//                       Padding(padding: EdgeInsets.only(top: 50.0)),
//                       MaterialButton(
//                         onPressed: submit,
//                         color: Theme.of(context).accentColor,
//                         height: 50.0,
//                         minWidth: 150.0,
//                         child: Text(
//                           "Зарегистрироваться",
//                           style: _sizeTextWhite,
//                         ),
//                       ),
//                       MaterialButton(
//                         onPressed: backToLogin,
//                         height: 30.0,
//                         minWidth: 150.0,
//                         child: Text(
//                           "У меня уже есть аккаунт",
//                           style: _sizeTextGrey,
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//         ));
//   }
//
//   void submit() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       performLogin(form);
//     }
//   }
//
//   void performLogin(form) async {
//     hideKeyboard();
//     http.Response response =
//         await http.post(Uri.encodeFull(url + '/Reg.php'), headers: {
//       'Accept': 'application/json'
//     }, body: {
//       'email': _email,
//       'password': _password,
//       'first_name': _firstName,
//       'last_name': _lastName,
//       'phone': _phone
//     });
//
//     if (response.statusCode == 201) {
//       Navigator.push(
//           _context,
//           new MaterialPageRoute(
//               builder: (context) => new MyBottomNavigationBar()));
//       //TODO: add snakebar "user created"
//     } else {
//       print(response.body);
//     }
//   }
//
//
//   void backToLogin() {
//     Navigator.pop(
//         _context, new MaterialPageRoute(builder: (context) => AuthPage()));
//   }
// }
//
// void hideKeyboard() {
//   SystemChannels.textInput.invokeMethod('TextInput.hide');
// }
// //  _showSnackBar(){
// //    final snackBar = new SnackBar(
// //        content: new Text("Новый пользователь создан!"));
// //  _scaffoldKey.currentState.showSnackBar(snackBar);
// //  }
//
// // 'http://192.168.0.104:8000/api/v1/auth/users/
import 'dart:convert';

import 'package:digitalpendal/screens/Widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import 'AuthPage.dart';
class RegistrationPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool visible = true;
  String email, password, firstName, lastName, phone;
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
                children: <Widget>[_formUI(), ]))
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
          SizedBox(height: 12.0),
          _inputFirstName(),
          SizedBox(height: 12.0),
          _inputLastName(),
          SizedBox(height: 12.0),
          _inputPhone(),
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
                child: Text("зарегистрироваться".toUpperCase()),
                onPressed: () {
                  _sendToServer();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              )),
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
  _inputFirstName() {
    return TextFormField(
      controller: _firstController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'First Name',
        prefixIcon: _prefixIcon(Icons.person_rounded),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.text,
      validator: validateName,
      onSaved: (str) {
        firstName = str;
      },
    );
  }
  _inputLastName() {
    return TextFormField(
      controller: _lastController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Last Name',
        prefixIcon: _prefixIcon(Icons.person_rounded),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.text,
      validator: validateName,
      onSaved: (str) {
        lastName = str;
      },
    );
  }
  _inputPhone() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Phone',
        prefixIcon: _prefixIcon(Icons.phone),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.phone,
      validator: validateName,
      onSaved: (str) {
        phone = str;
      },
    );
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

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _performLogin();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
   _performLogin() async {
    http.Response response =
        await http.post(Uri.encodeFull(url + '/Reg.php'),
            body: {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone
    });
    if (response.statusCode == 201) {
     // _showSnackBar();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new MyBottomNavigationBar()));

    } else {
      print(response.body);
    }
  }
 //   _showSnackBar(){
 //   final snackBar = SnackBar(
 //     duration: const Duration(seconds: 10),
 //       content: Text("Новый пользователь создан!"));
 // Scaffold.of(context).showSnackBar(snackBar);
 // }
  _linkSignUp() => Padding(
    padding: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Уже есть аккаунт?',
            style: TextStyle(color: Colors.grey)),
        FlatButton(
          child: Text('Войдите',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
          onPressed: () {
            _Auth();
          },
        ),
      ],
    ),
  );
  _Auth() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  AuthPage()));
  }
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
    return 'Пароль не может быть пустым';
  } else if (value.length < 4) {
    return 'Пароль не может содержать меньше 4 символов';
  }
  return null;
}
String validateName(String value) {
  if (value.isEmpty) {
    return 'Имя/фамилия не может быть пустым';
  } else if (value.length > 25){
    return 'Слишком длинное имя/фамилия';
  }
  return null;
}
String validatePhone(String value) {
  if (value.isEmpty) {
    return 'Телефон не может быть пустым';
  } else if (value.length > 13){
    return 'Некорректный номер';
  }
  return null;
}
