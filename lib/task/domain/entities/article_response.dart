import 'package:equatable/equatable.dart';
import 'article.dart';

class ArticlesPage extends Equatable {
  final List<Article> articles;
  final int totalArticles;

  const ArticlesPage({
    required this.articles,
    required this.totalArticles,
  });

  @override
  List<Object> get props => [
    articles,
    totalArticles,
  ];
}