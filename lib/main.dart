import 'package:flutter/material.dart';
import 'package:moie_explorer/home.dart';
import 'package:provider/provider.dart';

import 'NumberProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumberProvider())
      ],
      child: const MaterialApp(
        title: 'Counter',
        home: Home(),
      ),
    );
  }
}
