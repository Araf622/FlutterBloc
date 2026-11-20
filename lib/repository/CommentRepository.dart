import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moie_explorer/model/CommentModel.dart';

class CommentRepository {
  Future<List<CommentModel>> fetchComments(int postId) async {
    String url = 'https://jsonplaceholder.typicode.com/posts/$postId/comments';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to load comments (${response.statusCode})');
      }

      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load comments (${e.toString()})');
    }
  }
}