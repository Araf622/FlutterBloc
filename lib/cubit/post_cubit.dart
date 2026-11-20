import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moie_explorer/model/UserModel.dart';
import 'package:moie_explorer/repository/PostRepository.dart';
import 'package:moie_explorer/repository/UserRepository.dart';

import '../model/PostModel.dart';
import '../model/PostWithUser.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;
  final UserRepository _userRepository;
  PostCubit(this._postRepository, this._userRepository) : super(PostInitial());

  Future<void> getPosts() async {
    final List<PostModel> posts;
    final List<UserModel> users;
    try {
      emit(PostLoading());
      posts = await _postRepository.fetchPost();
      users = await _userRepository.fetchUsers();

      final usersById = {for (final u in users) u.id : u};
      final items = posts
          .map((p) => PostWithUser(post: p, user: usersById[p.userId]))
          .toList();

      emit(PostLoaded(items));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}