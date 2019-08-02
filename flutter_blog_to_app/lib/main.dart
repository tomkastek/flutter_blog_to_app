import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog_to_app/api.dart';
import 'package:flutter_blog_to_app/blog_app.dart';

void main() {
  // TODO: add support for landscape
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  blogApi = BlogApi();

  return runApp(BlogApp());
}