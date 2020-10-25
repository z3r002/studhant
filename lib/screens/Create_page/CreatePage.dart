import 'package:digitalpendal/constants.dart';
import 'package:digitalpendal/screens/Authentication/AuthPage.dart';
import 'package:digitalpendal/screens/Widgets/NavBar.dart';
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

  EdgeInsets pad = EdgeInsets.only(top: 20.0);

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  checkLoginStatus() async {
    value = await storage.read(key: 'token');
    if (value == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => AuthPage()),
          (Route<dynamic> route) => false);
    }
    print('THIS FUCKING TOKEN ' + value);
  }

  BuildContext _context;
  DateTime pickedDate;
  TimeOfDay time;

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
                      Padding(padding: pad),
                      ListTile(
                        title: Text(
                            '${pickedDate.year}.${pickedDate.month}.${pickedDate.day}'),
                        onTap: _pickDate,
                      ),
                      ListTile(
                        title: Text(
                            '${time.hour}:${time.minute}'),
                        onTap: _pickTime,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Название работы",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
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
                        margin: pad,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Сколько людей нужно",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                          maxLines: 1,
                          validator: (val) =>
                              val.length < 0 ? 'количество меньше 0' : null,
                          onSaved: (val) => _countPeople = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: pad,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Введите сумму",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
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
                        margin: EdgeInsets.only(top: 20.0),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Срок исполнения",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          maxLines: 1,
                          validator: (val) =>
                              val.length < 0 ? 'Введите срок выполнения' : null,
                          onSaved: (val) => _executePeriod = val,
                          style: _sizeTextBlack,
                        ),
                        width: 340.0,
                        height: 50,
                        margin: pad,
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "краткое описание",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
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
                        margin: pad,
                      ),
                      Padding(padding: EdgeInsets.only(top: 50.0)),
                      MaterialButton(
                        onPressed: submit,
                        color: Colors.black,
                        height: 50.0,
                        minWidth: 150.0,
                        child: Text(
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

  _pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if(date != null){
      setState(() {
        pickedDate = date;
      });
    }
  }
  _pickTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: time,);

    if( t != null){
      setState(() {
        time = t;
      });
    }
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
        Uri.encodeFull(url + '/Data.php'),
        body: {
          'name': _name,
          'token': value,
          'description': _description,
          'count_people': _countPeople,
          'cost': _cost,
          'execute_period': _executePeriod
        });
    print(response.statusCode);
    if (response.statusCode == 201) {
      hideKeyboard();
      Navigator.push(
          _context,
          MaterialPageRoute(
              builder: (context) => MyBottomNavigationBar()));
    }
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
