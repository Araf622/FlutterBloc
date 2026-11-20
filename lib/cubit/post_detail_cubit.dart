import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moie_explorer/model/CommentModel.dart';
import 'package:moie_explorer/repository/CommentRepository.dart';

part 'post_detail_state.dart';

class PostDetailCubit extends Cubit<PostDetailState> {
  final CommentRepository commentRepository;
  PostDetailCubit(this.commentRepository) : super(PostDetailInitial());

  Future<void> getComments(int postId) async {
    try {
      emit(PostDetailLoading());
      final comments = await commentRepository.fetchComments(postId);
      emit(PostDetailLoaded(comments));
    } catch (e) {
      emit(PostDetailError(e.toString()));
    }
  }
}
