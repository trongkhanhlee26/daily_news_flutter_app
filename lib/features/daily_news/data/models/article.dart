import 'package:flutter_1/features/daily_news/domain/entities/article.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel(
    super.author,
    super.id,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      json['author'] as String?,
      json['id'] as int?,
      json['title'] as String?,
      json['description'] as String?,
      json['url'] as String?,
      json['urlToImage'] as String?,
      json['publishedAt'] as String?,
      json['content'] as String?,
    );
  }
}