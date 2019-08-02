import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tom Kastek\'s Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'All Posts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Post>> fetchPost() async {
    final response =
        await http.get('https://tomkastek.com/wp-json/wp/v2/posts');

    if (response.statusCode == 200) {
      var data = response.body;
      var json = jsonDecode(data);
      List<Post> posts = [];
      for (var postJson in json) {
        var post = Post.fromJson(postJson);
        posts.add(post);
      }
      return posts;
      // If the call to the server was successful, parse the JSON.
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Post>>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var posts = snapshot.data;

                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Text(posts[index].title);
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('ERROR'),
                );
              }
              return Center(child: CircularProgressIndicator());
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

/// Json docs: https://flutter.dev/docs/development/data-and-backend/json
class Post {
  //  final String ping_status; // "open"
  //  final bool sticky;
  //  guid = url/?id
  //  String excerpt; <- same as content?
  //  int featured_media; <- what is this?
  // meta
  // categories
  // tags
  // _links
  // final String template;
  final int id;
  final String date;
  final String date_gtm;
  final String modified;
  final String modified_gmt; // important to compare if I need to refresh cache
  final String slug; // end of url (/beitrag_name)
  final String status; // publish
  final String type; // post
  final String link; // URL of post
  final String title; // [title][rendered]
  final String content; // the body
  final int author; // int. need to load user data to display
  final String comment_status; // "open"
  final String format;

  Post(
      this.id,
      this.date,
      this.date_gtm,
      this.modified,
      this.modified_gmt,
      this.slug,
      this.status,
      this.type,
      this.link,
      this.title,
      this.content,
      this.author,
      this.comment_status,
      this.format);

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        date_gtm = json['date_gtm'],
        modified = json['modified'],
        modified_gmt = json['modified_gmt'],
        slug = json['slug'],
        status = json['status'],
        type = json['type'],
        link = json['link'],
        title = json['title']['rendered'],
        content = json['content']['rendered'],
        author = json['author'],
        comment_status = json['comment_status'],
        format = json['format'];

  Map<String, String> _titleMap() => {'rendered': title};

  Map<String, String> _contentMap() => {'rendered': content};

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'date_gtm': date_gtm,
        'modified': modified,
        'modified_gmt': modified_gmt,
        'slug': slug,
        'status': status,
        'type': type,
        'link': link,
        'title': _titleMap(),
        'content': _contentMap(),
        'author': author,
        'comment_status': comment_status,
        'format': format
      };
}
