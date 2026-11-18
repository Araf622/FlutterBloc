import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moie_explorer/cubit/post_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PostCubit(),
        child: const PostScreen(),
      ),
    );
  }
}

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This context is below the BlocProvider, so PostCubit lookups work.
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: Center(
        child: Column(
          children: [
            BlocConsumer<PostCubit, PostState>(
              listener: (context, state) {
                if (state is PostError) {
                  showErrorSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is PostLoading) {
                  return loadingIndicator();
                } else if (state is PostLoaded) {
                  return postDetails(id: state.id, post: state.post);
                } else {
                  return const Text("Click the button below to fetch post");
                }
              },
            ),
            fetchPostButton(context),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// UI building blocks. Wire these up with your cubit (BlocBuilder/BlocListener).
// ---------------------------------------------------------------------------

/// Button that fetches the post. onPressed is intentionally left empty.
Widget fetchPostButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      final postCubit = BlocProvider.of<PostCubit>(context);
      postCubit.getPost();
    }, // TODO: call context.read<PostCubit>().getPost()
    child: const Text('Fetch Post'),
  );
}

/// Shows the post id and the post text. Use for the loaded state.
Widget postDetails({required int id, required String post}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Post ID: $id'),
        const SizedBox(height: 8),
        Text(post),
      ],
    ),
  );
}

/// Spinner for the loading state.
Widget loadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

/// Snackbar for the error state.
void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
