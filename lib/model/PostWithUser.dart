import 'package:equatable/equatable.dart';

import 'PostModel.dart';
import 'UserModel.dart';

class PostWithUser extends Equatable {
  final PostModel post;
  final UserModel? user;

  const PostWithUser({
    required this.post,
    this.user,
  });

  @override
  List<Object?> get props => [post, user];
}
