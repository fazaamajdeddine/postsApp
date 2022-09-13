import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/helpers/apiHelper.dart';
import 'package:providerapp/models/post.dart';
import 'package:providerapp/providers/homePageProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  _showSnackbar(String message, {Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor ?? Colors.red,
      ),
    );
  }

  _hideSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  _getPosts() async {
    var provider = Provider.of<HomePAgeProvider>(context, listen: false);
    var response = await APIHelper.getPosts();
    if (response.isSuccessful) {
      provider.setPostList(response.data!);
    } else {
      _showSnackbar(response.message!);
    }
    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Provider Rest',
        ),
      ),
      body: Consumer<HomePAgeProvider>(
        builder: (_, provider, __) => provider.isProcessing
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.pinkAccent,
                ),
              )
            : ListView.builder(
                itemBuilder: (_, index) {
                  Post post = provider.getPostByIndex(index);
                  return ListTile(
                    title: Text(post.title!),
                    subtitle: Text(
                      post.body!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
                itemCount: provider.postList.length,
              ),
      ),
    );
  }
}
