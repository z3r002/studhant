import 'package:digitalpendal/constants.dart';
import 'package:digitalpendal/screens/Widgets/NavBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _phone;
  int id;
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final _sizeTextGrey = const TextStyle(fontSize: 20.0, color: Colors.grey);

  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Container(
                        child: TextFormField(
                          //decoration: new InputDecoration(labelText: "Почта"),
                          decoration: InputDecoration(
                            labelText: "Почта",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
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
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Пароль",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          obscureText: true,
                          maxLines: 1,
                          validator: (val) => val.length < 6
                              ? 'Пароль меньше 6 символов.'
                              : null,
                          onSaved: (val) => _password = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: EdgeInsets.only(top: 20.0),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Фамилия",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
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
                        margin: EdgeInsets.only(top: 20.0),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Имя",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
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
                        margin: EdgeInsets.only(top: 20.0),
                      ),

                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Телефон",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
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
                        margin: EdgeInsets.only(top: 20.0),
                      ),
                      Padding(padding: EdgeInsets.only(top: 50.0)),
                      MaterialButton(
                        onPressed: submit,
                        color: Theme.of(context).accentColor,
                        height: 50.0,
                        minWidth: 150.0,
                        child: Text(
                          "Зарегистрироваться",
                          style: _sizeTextWhite,
                        ),
                      ),
                      MaterialButton(
                        onPressed: backToLogin,
                        height: 30.0,
                        minWidth: 150.0,
                        child: Text(
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
    http.Response response =
        await http.post(Uri.encodeFull(url + '/Reg.php'), headers: {
      'Accept': 'application/json'
    }, body: {
      'email': _email,
      'password': _password,
      'first_name': _firstName,
      'last_name': _lastName,
      'phone': _phone
    });

    if (response.statusCode == 201) {
      Navigator.push(
          _context,
          new MaterialPageRoute(
              builder: (context) => new MyBottomNavigationBar()));
      //TODO: add snakebar "user created"
    } else {
      print(response.body);
    }
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
