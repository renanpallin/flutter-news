import 'dart:convert';
import 'package:flutter_news/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

final API_ROOT = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  
  Client client = Client();
  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$API_ROOT/topstories.json');
    final ids = json.decode(response.body);
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$API_ROOT/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}