import 'package:flutter/material.dart';
import 'package:moie_explorer/second.dart';
import 'package:provider/provider.dart';

import 'NumberProvider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumberProvider>(
      builder: (context, provider, child) {
        final numbers = provider.numbers;
        return Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            child: Column(
              children: [
                Text(numbers.last.toString(), style: TextStyle(fontSize: 30),),
                Expanded(
                  child: ListView.builder(
                    itemCount: numbers.length,
                    itemBuilder: (context, index) {
                      return Text(numbers[index].toString(), style: TextStyle(fontSize: 20),);
                    },),
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));
                    },
                    child: Text("Navigate"))
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: provider.add,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
