import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:moie_explorer/PostDataModel.dart';
import 'package:http/http.dart' as http;

Future<PostDataModel?> getSinglePostData() async {
  PostDataModel? result;

  try {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/2"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      }
    );

    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      result = PostDataModel.fromJson(item);
    } else {
      log("Unable to fetch data");
    }
  } catch (e) {
    log(e.toString());
  }

  return result;
}