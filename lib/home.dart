import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moie_explorer/PostData.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    final postData = Provider.of<PostData>(context, listen: false);
    postData.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostData>(
      builder: (context, postData, child) {
        return Scaffold(
          appBar: AppBar(),
          body: postData.isLoading? const Center(
            child: SpinKitThreeBounce(color: Colors.blue, size: 30),
          ) :
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    postData.post?.title ?? "",
                    style: TextStyle(
                        fontSize: 24
                    ),),
                  Text(
                    postData.post?.body ?? "",
                    style: TextStyle(
                        fontSize: 18
                    ),),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
