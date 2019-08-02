import 'package:flutter_blog_to_app/post.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

BlogApi blogApi;

class BlogApi {
  static const postsURL = 'https://tomkastek.com/wp-json/wp/v2/posts';
  static const mediaURL = 'https://tomkastek.com/wp-json/wp/v2/media/';

  Future<List<Post>> fetchPost() async {
    final response = await http.get(postsURL);

    if (response.statusCode == 200) {
      var data = response.body;
      var json = jsonDecode(data);
      List<Post> posts = [];
      for (var postJson in json) {
        var post = Post.fromJson(postJson);
        var featured_image = await imageURL(post.featured_media);
        post..featured_image = featured_image;
        posts.add(post);
      }
      return posts;
      // If the call to the server was successful, parse the JSON.
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  /// help: https://flutter.dev/docs/cookbook/images/network-image
  Future<String> imageURL(int media_id) async {
    final response = await http.get(mediaURL + '$media_id');

    if (response.statusCode == 200) {
      var data = response.body;
      var json = jsonDecode(data);
      return json['source_url'];
    } else {
      return '';
    }
  }
}
