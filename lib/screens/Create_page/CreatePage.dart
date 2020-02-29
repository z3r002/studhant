import 'package:digitalpendal/main.dart';
import 'package:digitalpendal/screens/Authentication/AuthPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final formKey = new GlobalKey<FormState>();

  String _name;
  String _description;
  String _countPeople;
  String _cost;
  String _executePeriod;
  String value;

  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    value = await storage.read(key: 'auth_token');
    if (value == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => AuthPage()),
          (Route<dynamic> route) => false);
    }
  }

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
                          decoration: new InputDecoration(
                            labelText: "Название работы",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                              val.length < 2 ? 'Ввидите название' : null,
                          onSaved: (val) => _name = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Сколько людей нужно",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                              val.length < 0 ? 'количество меньше 0' : null,
                          onSaved: (val) => _countPeople = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Введите сумму",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                              val.length < 0 ? 'сумма мала' : null,
                          onSaved: (val) => _cost = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Срок исполнения",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                              val.length < 0 ? 'Введиnt срок выполнения' : null,
                          onSaved: (val) => _executePeriod = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "краткое описание",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                              val.length < 2 ? 'Введите описание' : null,
                          onSaved: (val) => _description = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: new EdgeInsets.only(top: 20.0),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 50.0)),
                      new MaterialButton(
                        onPressed: submit,
                        color: Theme.of(context).accentColor,
                        height: 50.0,
                        minWidth: 150.0,
                        child: new Text(
                          "Создать",
                          style: _sizeTextWhite,
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
    String token = "Token " + value;

    http.Response response = await http.post(
        Uri.encodeFull('http://192.168.0.104:8000/api/v1/jobs/job/create/'),
        headers: {
          'Accept': 'application/json',
          //'Authorization': 'Token 82b6a5bcf7ad37f45de2a3e89bfea52f23bfb87a'//admin worked hardcore
          'Authorization': token
        },
        body: {
          'name': _name,
          'description': _description,
          'count_people': _countPeople,
          'cost': _cost,
          'execute_period': _executePeriod
        });
    if (response.statusCode == 201) {
      //storage.setItem('user', jsonEncode(response.body));
      hideKeyboard();
      Navigator.push(
          _context,
          new MaterialPageRoute(
              builder: (context) => new MyBottomNavigationBar()));
    }
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
