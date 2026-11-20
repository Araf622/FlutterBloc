import 'PostModel.dart';
import 'UserModel.dart';

class PostWithUser {
  final PostModel post;
  final UserModel? user;

  const PostWithUser({
    required this.post,
    this.user,
  });
}
