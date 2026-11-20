import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moie_explorer/cubit/post_cubit.dart';
import 'package:moie_explorer/homepage.dart';
import 'package:moie_explorer/repository/CommentRepository.dart';
import 'package:moie_explorer/repository/PostRepository.dart';
import 'package:moie_explorer/repository/UserRepository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PostRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => CommentRepository()),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("JsonTypeHolder Posts"),
            backgroundColor: Colors.blueAccent,
          ),
          body: Center(
            child: BlocProvider(
              create: (context) => PostCubit(
                context.read<PostRepository>(),
                context.read<UserRepository>(),
              ),
              child: const Homepage(),
            ),
          ),
        ),
      ),
    );
  }
}
