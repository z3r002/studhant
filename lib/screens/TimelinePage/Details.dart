import 'package:flutter/material.dart';
import 'album.dart';

class Details extends StatefulWidget {
  Details({@required this.curAlbum});
 // Details({@required this.imageProvider, this.curAlbum});

  //final ImageProvider imageProvider;
  final Album curAlbum;

  @override
  GridDetailsState createState() => GridDetailsState();
}

class GridDetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

       home: Scaffold(

          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "image${widget.curAlbum.id}",
                  child: Image.asset('images/noimage-md.png',),
                  // widget.curAlbum.id,
                  // child: FadeInImage.assetNetwork(
                  //     placeholder: "images/noimage-md.png",
                  //     //image: widget.curAlbum.,
                  //     image: "images/noimage-md.png"),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        widget.curAlbum.name,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        widget.curAlbum.cost + " р.",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text(
                        "Найдено: " +
                            // widget.curAlbum.find +
                            "/" +
                            widget.curAlbum.count_people,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  ],

                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 11, 0, 0),
                      child: Text(
                        "Описание: " +
                            widget.curAlbum.description,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                MaterialButton(
                  color: Colors.green,
                  child: Text("Принять",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),),
                  onPressed: () => Navigator.of(context).pop(),
                ),

           SizedBox(
             height: 30.0,
           ),
           OutlineButton(
             child: Icon(Icons.close),
             onPressed: () => Navigator.of(context).pop(),
           ),
              ],
            ),
          ),
        ),
    );

  }
}
// import 'package:flutter/material.dart';
// import 'album.dart';
//
// class GridDetails extends StatefulWidget {
//   final Album curAlbum;
//   GridDetails({@required this.curAlbum});
//
//   @override
//   GridDetailsState createState() => GridDetailsState();
// }
//
// class GridDetailsState extends State<GridDetails> {
//   //
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         margin: EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FadeInImage.assetNetwork(
//               placeholder: "images/no_image.png",
//               image: "images/no_image.png",
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
//             OutlineButton(
//               child: Icon(Icons.close),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
