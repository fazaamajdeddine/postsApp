import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:providerapp/models/httpresponse.dart';
import 'package:providerapp/models/post.dart';

class APIHelper {
  static Future<HTTPResponse<List<Post>>> getPosts(
      {int limit = 20, int page = 1}) async {
    String url =
        'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page';
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Post> postsList = [];
        body.forEach((e) {
          Post post = Post.fromJson(e);
          postsList.add(post);
        });
        return HTTPResponse(
          true,
          postsList,
          responseCode: response.statusCode,
        );
      } else {
        return HTTPResponse(
          true,
          null,
          message: 'invalid response recieved from server! please try again...',
          responseCode: response.statusCode,
        );
      }
    } on SocketException {
      return HTTPResponse(
        false,
        null,
        message: "Unable to reach the internet!... Please try again.",
      );
    } on FormatException {
      return HTTPResponse(false, null,
          message:
              'invalid response recieved from server! please try again...');
    } catch (e) {
      return HTTPResponse(false, null,
          message: 'Somthing went wrong! Please try again...');
    }
  }
}
