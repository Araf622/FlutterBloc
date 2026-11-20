part of 'post_cubit.dart';

@immutable
sealed class PostState {
  const PostState();
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostLoaded extends PostState {
  final List<PostWithUser> posts;
  const PostLoaded(this.posts);
}

final class PostError extends PostState {
  final String message;
  const PostError(this.message);
}

