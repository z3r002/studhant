import 'package:digitalpendal/screens/Authentication/AuthPage.dart';
import 'package:digitalpendal/screens/ProfilePage/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'services_pp.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<UserData> futureUserData;

  @override
  void initState() {
    super.initState();
    futureUserData = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
        future: futureUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(
                top: 30,
                left: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        snapshot.data.first_name +
                            '  ' +
                            snapshot.data.last_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 20),
                        child: ClipOval(
                          child: Image.asset(
                            "images/profile.png",
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    'Номер профиля\n' + 'id ' + snapshot.data.id,
                    style: TextStyle(fontSize: 16),
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      children: [
                        WidgetSpan(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 12, top: 12),
                          child: Icon(Icons.email),
                        )),
                        TextSpan(
                            text: snapshot.data.email,
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      children: [
                        WidgetSpan(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 12, top: 12),
                          child: Icon(Icons.phone),
                        )),
                        TextSpan(
                            text: snapshot.data.phone,
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  FlatButton(
                    child: Text('Выйти',
                        style: TextStyle(
                            color: Colors.black87,
                            //decoration: TextDecoration.underline,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      logout();

                    },
                  ),
                ],
              ),
            );
            // return Text(snapshot.data.email);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return circularProgress();
        });
  }
  logout(){
    final storage = FlutterSecureStorage();
    var value = storage.delete(key: 'token');
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  AuthPage()));

  }
  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
}
