import 'package:digitalpendal/screens/ProfilePage/models.dart';
import 'package:flutter/material.dart';

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
              margin: EdgeInsets.only(top: 24, left: 12,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    snapshot.data.first_name + '  ' + snapshot.data.last_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),

                  Text(
                    'Номер профиля\n' + snapshot.data.id,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            );
            // return Text(snapshot.data.email);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
