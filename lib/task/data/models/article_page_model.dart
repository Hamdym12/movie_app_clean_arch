import '../../domain/entities/article_page.dart';
import 'article_model.dart';

class ArticlesPageModel extends ArticlesPage {
  const ArticlesPageModel({
    required super.articles,
    required super.totalArticles,
  });

  factory ArticlesPageModel.fromJson(Map<String, dynamic> json) {
    return ArticlesPageModel(
      articles: (json['blogs'] as List).map((e) {
      return ArticleModel.fromJson(e);
      }).toList(),
      totalArticles: json['total_blogs'] as int,
    );
  }
}