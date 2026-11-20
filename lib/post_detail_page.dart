import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moie_explorer/cubit/post_detail_cubit.dart';
import 'package:moie_explorer/model/CommentModel.dart';
import 'package:moie_explorer/model/PostWithUser.dart';
import 'package:moie_explorer/repository/CommentRepository.dart';

class PostDetailPage extends StatelessWidget {
  final PostWithUser postWithUser;

  const PostDetailPage({super.key, required this.postWithUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostDetailCubit(CommentRepository())
        ..getComments(postWithUser.post.id),
      child: _PostDetailView(postWithUser: postWithUser),
    );
  }
}

class _PostDetailView extends StatelessWidget {
  final PostWithUser postWithUser;

  const _PostDetailView({required this.postWithUser});

  @override
  Widget build(BuildContext context) {
    final post = postWithUser.post;
    final user = postWithUser.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 20),
                const SizedBox(width: 8),
                Text(
                  user?.name ?? 'Unknown author',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            if (user != null) ...[
              const SizedBox(height: 4),
              Text(user.email),
            ],
            const SizedBox(height: 16),
            Text(
              post.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Post ID: ${post.id}'),
            const SizedBox(height: 12),
            Text(post.body),
            const SizedBox(height: 24),
            const Text(
              'Comments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _commentsSection(context, post.id),
          ],
        ),
      ),
    );
  }

  Widget _commentsSection(BuildContext context, int postId) {
    return BlocBuilder<PostDetailCubit, PostDetailState>(
      builder: (context, state) {
        return switch (state) {
          PostDetailInitial() => const SizedBox(),
          PostDetailLoading() => const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ),
          PostDetailLoaded() => Column(
              children: state.comments.map(_commentItem).toList(),
            ),
          PostDetailError() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.message),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () =>
                      context.read<PostDetailCubit>().getComments(postId),
                  child: const Text('Retry'),
                ),
              ],
            ),
        };
      },
    );
  }

  Widget _commentItem(CommentModel comment) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(comment.email, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 6),
          Text(comment.body),
        ],
      ),
    );
  }
}
