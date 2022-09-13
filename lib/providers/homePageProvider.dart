import 'package:flutter/widgets.dart';
import 'package:providerapp/models/post.dart';

class HomePAgeProvider extends ChangeNotifier{
  bool _isProcessing = true;
  List<Post> _postList = [];
  bool get isProcessing => _isProcessing;
  setIsProcessing(bool value){
    _isProcessing = value;
    notifyListeners();
  }

  List<Post> get postList => _postList;

  setPostList(List<Post> list) {
    _postList = list;
    notifyListeners();
  }

  mergePostsList(List<Post> list) {
    _postList.addAll(list);
    notifyListeners();
  }
  
  Post getPostByIndex(int index) => _postList[index];
}