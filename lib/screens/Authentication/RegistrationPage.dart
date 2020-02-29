import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';
import 'AuthPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _email;
  String _password;
  String _lastName;
  String _firstName;
  String _middleName;
  String _phone;
  int id;
  final LocalStorage storage = new LocalStorage('some_key');
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final _sizeTextGrey = const TextStyle(fontSize: 20.0, color: Colors.grey);

  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          resizeToAvoidBottomPadding: false,
          body: new Center(
            child: SingleChildScrollView(
              child: new Form(
                  key: formKey,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      new Container(
                        child: new TextFormField(
                          //decoration: new InputDecoration(labelText: "Почта"),
                          decoration: new InputDecoration(
                            labelText: "Почта",
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
                          !val.contains("@") ? 'Некорректный email' : null,
                        ),
                        width: 340.0,
                        height: 50,
                      ),
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
                          val.length < 6
                              ? 'Пароль меньше 6 символов.'
                              : null,
                          onSaved: (val) => _password = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Фамилия",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                          val.length < 2 ? 'Введите фамилию' : null,
                          onSaved: (val) => _lastName = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Имя",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                          val.length < 2 ? 'Введите имя' : null,
                          onSaved: (val) => _firstName = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Отчество",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                          val.length < 2 ? 'Введите отчество' : null,
                          onSaved: (val) => _middleName = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Телефон",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                          val.length < 2 ? 'Введите телефон' : null,
                          onSaved: (val) => _phone = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 50.0)),
                      new MaterialButton(
                        onPressed: submit,
                        color: Theme
                            .of(context)
                            .accentColor,
                        height: 50.0,
                        minWidth: 150.0,
                        child: new Text(
                          "Зарегистрироваться",
                          style: _sizeTextWhite,
                        ),
                      ),
                      new MaterialButton(
                        onPressed: backToLogin,
                        height: 30.0,
                        minWidth: 150.0,
                        child: new Text(
                          "У меня уже есть аккаунт",
                          style: _sizeTextGrey,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }

  void submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      performLogin(form);
    }
  }

  void performLogin(form) async {
    hideKeyboard();
    http.Response response = await http.post(
        Uri.encodeFull('http://192.168.0.104:8000/api/v1/auth/users/'),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'email': _email,
          'password': _password,
          'first_name': _firstName,
          'last_name': _lastName,
          'middle_name': _middleName,
          'phone': _phone
        });
    if (response.statusCode == 201) {
      storage.setItem('user', jsonEncode(response.body));

      Navigator.push(
          _context,
          new MaterialPageRoute(
              builder: (context) => new MyBottomNavigationBar()));
      //TODO: add snakebar "user created"
    } else {
      print(response.body);
    }
    httpGet();
  }

   httpGet() async {
    http.Response response = await http.get(
        Uri.encodeFull('http://192.168.0.104:8000/api/v1/auth/users/'),
        headers: {
          'Accept': 'application/json'
        });
    print("responce status: ${response.statusCode}");
    print("responce body: ${response.body}");
  }


  void backToLogin() {
    Navigator.pop(
        _context, new MaterialPageRoute(builder: (context) => AuthPage()));
  }
}
  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
//  _showSnackBar(){
//    final snackBar = new SnackBar(
//        content: new Text("Новый пользователь создан!"));
//  _scaffoldKey.currentState.showSnackBar(snackBar);
//  }

// 'http://192.168.0.104:8000/api/v1/auth/users/
