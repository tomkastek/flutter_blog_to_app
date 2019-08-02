import 'package:flutter_html/flutter_html.dart';

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

  Html asHTML() {
    return Html(data: content,);
  }
}
