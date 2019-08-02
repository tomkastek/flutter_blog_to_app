import 'package:flutter/material.dart';
import 'package:flutter_blog_to_app/post.dart';

class AllPostsListPage extends StatelessWidget {
  const AllPostsListPage(
    this.data, {
    Key key,
  }) : super(key: key);

  final List<Post> data;

  @override
  Widget build(BuildContext context) {
    var posts = data;

    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var post = posts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              leading: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            body: SafeArea(
                                child: SingleChildScrollView(
                              child: post.asHTML(),
                            )),
                          );
                        },
                        fullscreenDialog: true));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 3,
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        post.featured_image,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            post.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
