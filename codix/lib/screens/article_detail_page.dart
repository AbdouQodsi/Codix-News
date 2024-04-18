import 'package:admob_flutter/admob_flutter.dart';
import 'package:codix/modals/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetailPage extends StatefulWidget {
  final Post post;

  ArticleDetailPage({required this.post});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        backgroundColor: const Color(0xFFFB8500),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured image
              Image.network(
                widget.post.featuredMedia,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
      
              // Title
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Html(data: widget.post.title),
              ),
      
              // Date
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text(
                  'Published on: ${widget.post.date}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
      
              // Content
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Html(data: widget.post.content,
                style: {
                  "img": Style(
                  width: Width(300, Unit.px),
                  height: Height(150, Unit.px),
                  alignment: Alignment.center, ),
                },
                ),
              ),
            ],
          ),
        ),
      ),

      
    );
  }
}
