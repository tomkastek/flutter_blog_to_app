import 'package:flutter/material.dart';
import 'package:flutter_blog_to_app/all_posts_page.dart';

class BlogApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tom Kastek\'s Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllPostsPage(title: 'All blog posts'),
    );
  }
}