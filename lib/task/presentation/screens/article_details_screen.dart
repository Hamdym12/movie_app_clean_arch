import 'package:flutter/material.dart';
import 'package:movie_app_clean_arch/task/domain/entities/article.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            child: Text(article.body),
          )
        ),
      )
    );
  }
}
