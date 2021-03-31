import 'dart:convert';
import 'dart:io';

import 'package:QuatesApp/UI/Home/Controller/fav_controller.dart';
import 'package:QuatesApp/UI/Home/Model/myDB.dart';
import 'package:QuatesApp/UI/Home/Model/quotes.dart';
import 'package:QuatesApp/UI/Home/Model/record.dart';
import 'package:QuatesApp/UI/Home/Model/tag.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient._();

  static final ApiClient apiClient = ApiClient._();

  static final http.Client _httpClient = http.Client();

  //Dev API
  // static final String _DEV_URL = "";

  //Prod API
  static final String _DEV_URL = "https://api.quotable.io";

  static final String _BASE_URL = "$_DEV_URL";

  Future<Tag> getQuote() async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };

    try {
      final response = await _httpClient.get(
        "$_BASE_URL/random?tags=inspirational",
        headers: header,
      );

      print("getCategories: " + response.body);
      Tag tag = Tag.fromRawJson(response.body);

      if (response.statusCode == 200) {
        // store in DB.
        Record record = Record(
          tag.id,
          tag.content,
          tag.author,
          0, // 0 = false
        );
        SQLiteDbProvider.db.insert(record);
      }

      return tag;
      // return Tag.fromJson(jsonDecode(response.body));
    } on SocketException {
      return Future.error("check your internet connection");
    } on http.ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      print("getCategories " + e.toString());
      return Future.error("Server Error");
    }
  }

  //https://api.quotable.io/quotes?tags=inspirational&max=20
  Future<Quotes> getQuotes(int skip) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      // 'token': mUserToken,
    };

    try {
      final response = await _httpClient.get(
        "$_BASE_URL/quotes?tags=inspirational&skip=$skip&limit=10",
        headers: header,
      );

      print("getQuotes: " + response.body);
      var json = jsonDecode(response.body);
      return Quotes.fromJson(json);
    } on SocketException {
      return await FavController.controller.getAllQuotes().then((value) {
        var list = value.map((e) {
          return Result(
            tags: [],
            id: e.id,
            content: e.content,
            author: e.author,
            isLiked: e.isLiked == 0 ? false : true,
            length: 0,
          );
        }).toList();
        return Quotes(
          results: list,
        );
      });
      // return Future.error("check your internet connection Socket Side");
    } on http.ClientException {
      return Future.error("check your internet connection Client Side");
    } catch (e) {
      print("getQuotes " + e.toString());
      return Future.error("Server Error");
    }
  }
}
