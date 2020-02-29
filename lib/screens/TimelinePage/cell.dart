import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'album.dart';

class AlbumCell extends StatelessWidget {
  const AlbumCell(this.album);

  @required
  final Album album;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Hero(
                    tag: "image${album.id}",
                    child: FadeInImage.assetNetwork(
                      placeholder: "images/noimage-md.png",
                      //image: album.thumbnailUrl,
                      image: "images/noimage-md.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child:Text(
                      album.name,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )

                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    album.cost + " р.",
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                  Spacer(),
                  Text(
                    "Найдено: " + album.find + "/" + album.count_people,
                    softWrap: false,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
