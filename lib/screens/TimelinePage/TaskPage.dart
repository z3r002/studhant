import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Details.dart';
import 'album.dart';
import 'cell.dart';
import 'services.dart';

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  gridview(BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: snapshot.data.map(
          (album) {
            return GestureDetector(

              child: GridTile(
                child: AlbumCell(album),
              ),
              onTap: () {

               goToDetails(context, album);
                //goToDetails();
              },
            );
          },
        ).toList(),
      ),
    );
  }
  goToDetails(BuildContext context, Album album) {
    Navigator.push(

      context,
      MaterialPageRoute(

        fullscreenDialog: true,
        builder: (BuildContext context) => Details(
          curAlbum: album,
        ),
      ),
    );
  }
  // goToDetails() {
  //   Navigator.push(
  //
  //     context,
  //     MaterialPageRoute(
  //
  //       fullscreenDialog: true,
  //       builder: (BuildContext context) => Details(
  //
  //       ),
  //     ),
  //   );
  // }

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: FutureBuilder<List<Album>>(
                future: Services.getPhotos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return gridview(context, snapshot);
                  }
                  return circularProgress();
                },
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
