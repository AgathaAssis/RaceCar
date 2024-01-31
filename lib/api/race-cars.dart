// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter_racecar/model/race-car.dart';
import 'package:http/http.dart' as http;
import 'base.dart';

class RaceCarApi {
  static String url = "${BaseApi.url}/race-car";

  static Future<List<RaceCar>> getAll() async {
    final res = await http.get(Uri.parse("$url/"));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body.toString());
      return data.map<RaceCar>((json) => RaceCar.fromJson(json)).toList();
    } else {
      throw Exception(res.body.toString());
    }
  }

  static Future create(RaceCar raceCar) async {
    final res = await http.post(Uri.parse("$url/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(raceCar.toJson()));
    if (res.statusCode == 201) {
      return;
    } else {
      throw Exception(res.body.toString());
    }
  }

  static Future update(RaceCar raceCar) async {
    final res = await http.put(Uri.parse("$url/${raceCar.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(raceCar.toJson()));
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception(res.body.toString());
    }
  }

  static Future delete(int id) async {
    final res = await http.delete(Uri.parse("$url/$id"));
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception(res.body.toString());
    }
  }
}
