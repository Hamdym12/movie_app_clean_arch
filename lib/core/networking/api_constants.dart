import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final baseUrl = dotenv.env['BASE_API_URL'];
  static final String getArticlesPath = "$baseUrl/sample-data/blog-posts";
}

