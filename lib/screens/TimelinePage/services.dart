import 'dart:convert';
import 'package:digitalpendal/constants.dart';
import 'package:http/http.dart' as http;
import 'album.dart';

class Services {

  static Future<List<Album>> getPhotos() async {
    try {
      http.Response response = await http.get(Uri.encodeFull(url + '/Data.php'));
      if (response.statusCode == 200) {
        List<Album> list = parsePhotos(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Album> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }
}
