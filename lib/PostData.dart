
import 'package:flutter/cupertino.dart';
import 'package:moie_explorer/PostDataModel.dart';
import 'package:moie_explorer/PostService.dart';

class PostData extends ChangeNotifier{
   PostDataModel? post;
   bool isLoading = true;

  Future<void> getPostData() async{
    isLoading = true;

    post = await getSinglePostData();
    isLoading = false;
    notifyListeners();
  }
}