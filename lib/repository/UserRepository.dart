import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/UserModel.dart';

class UserRepository {
  static const String _url = 'https://jsonplaceholder.typicode.com/users';

  List<UserModel>? _cachedUsers;

  Future<List<UserModel>> fetchUsers() async {
    if (_cachedUsers != null) return _cachedUsers!;

    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode != 200) {
        throw Exception('Failed to load users (${response.statusCode})');
      }

      final List<dynamic> data = jsonDecode(response.body);
      _cachedUsers = data
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return _cachedUsers!;
    } catch (e) {
      throw Exception('Failed to load users (${e.toString()})');
    }
  }
}
