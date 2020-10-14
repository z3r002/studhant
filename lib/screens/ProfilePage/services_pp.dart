import 'dart:convert';
import 'package:digitalpendal/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

final storage = FlutterSecureStorage();

Future<UserData> fetch() async {
  String value = await storage.read(key: 'token');
  final response = await http.post(url + '/Data.php', body: {'token': value});
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return UserData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
