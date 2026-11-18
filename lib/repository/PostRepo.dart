import 'dart:io';
import 'dart:math';

import '../model/PostModel.dart';

Future<PostModel?> fetchPost() {
  return Future.delayed(
      const Duration(seconds: 2),
      () {
        final randomNumber = Random().nextInt(100);

        if (randomNumber.isOdd) {
          return PostModel(
              id: 1,
              post: "Tottenham are trying tonight to become the first "
                  "London team to win the cup. The last team to do so "
                  "was the 1973 Spurs team.");
        } else {
          throw const SocketException("Network error: failed to fetch post");
        }
      }
  );
}
