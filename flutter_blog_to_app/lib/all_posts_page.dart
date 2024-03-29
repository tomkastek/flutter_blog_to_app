import 'package:flutter/material.dart';
import 'package:flutter_blog_to_app/all_posts_list_page.dart';
import 'package:flutter_blog_to_app/api.dart';
import 'package:flutter_blog_to_app/post.dart';

class AllPostsPage extends StatefulWidget {
  AllPostsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AllPostsPageState createState() => _AllPostsPageState();
}

class _AllPostsPageState extends State<AllPostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Post>>(
            future: blogApi.fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AllPostsListPage(snapshot.data);
              } else if (snapshot.hasError) {
                return _AllPostsWithoutData();
              }
              return _AllPostsLoading();
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class _AllPostsWithoutData extends StatelessWidget {
  const _AllPostsWithoutData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('ERROR'),
    );
  }
}

class _AllPostsLoading extends StatelessWidget {
  const _AllPostsLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
