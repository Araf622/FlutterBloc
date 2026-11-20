part of 'post_detail_cubit.dart';

@immutable
sealed class PostDetailState {
  const PostDetailState();
}

final class PostDetailInitial extends PostDetailState {}
final class PostDetailLoading extends PostDetailState {}

final class PostDetailLoaded extends PostDetailState {
  final List<CommentModel> comments;
  const PostDetailLoaded(this.comments);
}

final class PostDetailError extends PostDetailState {
  final String message;
  const PostDetailError(this.message);
}
