import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moie_explorer/repository/PostRepo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  Future<void> getPost() async {
    try {
      emit(PostLoading());
      final post = await fetchPost();

      if (post == null) {
        emit(PostError("Couldn't fetch post!!"));
      }
      emit(PostLoaded(post!.id, post.post));
    } catch(e) {
      emit(PostError("Couldn't fetch post!!"));
    }
  }
}
