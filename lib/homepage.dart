import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moie_explorer/model/PostWithUser.dart';
import 'package:moie_explorer/post_detail_page.dart';

import 'cubit/post_cubit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<PostCubit, PostState>(
        listener: (context, Object? state) {
          if (state is PostError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          switch (state) {
            case PostInitial():
              return _fetchButton();
            case PostLoading():
              return _loadingIndicator();
            case PostLoaded():
              return _postItem(state.posts);
            default:
              return SizedBox();
          }
        },
      ),
    );
  }

  Widget _fetchButton() {
    return ElevatedButton(
        onPressed: () {
          BlocProvider.of<PostCubit>(context).getPosts();
        },
        child: const Text('Fetch Posts'));
  }

  Widget _loadingIndicator() {
    return const CircularProgressIndicator();
  }

  Widget _postItem(List<PostWithUser> postsWithUser) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: postsWithUser.length,
      itemBuilder: (context, index) {
        final post = postsWithUser[index].post;
        final user = postsWithUser[index].user;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PostDetailPage(postWithUser: postsWithUser[index]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18),
                      const SizedBox(width: 6),
                      Text(user?.name ?? 'Unknown author'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(post.body),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
