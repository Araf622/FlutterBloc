import 'package:flutter/material.dart';
import 'package:moie_explorer/NumberProvider.dart';
import 'package:provider/provider.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumberProvider>(
      builder: (BuildContext context, provider, child) {
        final numbers = provider.numbers;
        return Scaffold (
          appBar: AppBar(),
          body: SizedBox(
            child: Column(
              children: [
                Text(provider.numbers.last.toString(), style: TextStyle(fontSize: 30),),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: numbers.length,
                    itemBuilder: (context, index) {
                      return Text(numbers[index].toString(), style: TextStyle(fontSize: 20),);
                    },),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                provider.add();
              });
            },
            child: Icon(Icons.add),
          ),
        );
      },

    );
  }
}
