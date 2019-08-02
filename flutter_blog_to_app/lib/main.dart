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
  Future<Html> fetchPost() async {
    final response =
        await http.get('https://tomkastek.com/wp-json/wp/v2/posts');

    if (response.statusCode == 200) {
      var data = response.body;
      var json = jsonDecode(data);
      var post = json[1]["content"]["rendered"];
      var html = Html(data: post, blockSpacing: 0,);
      return html;
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
        body: FutureBuilder(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(child: SingleChildScrollView(child: snapshot.data,));
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
