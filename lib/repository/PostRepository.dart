import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/PostModel.dart';

class PostRepository {
  static const String _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode != 200) {
        throw Exception('Failed to load posts (${response.statusCode})');
      }

      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load posts (${e.toString()})');
    }
  }
}
