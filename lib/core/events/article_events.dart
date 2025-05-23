import 'package:flutter_1/features/daily_news/data/models/article.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';

class ArticleSavedEvent {
  final ArticleEntity ? article;
  ArticleSavedEvent(this.article);
}

class ArticleRemovedEvent {
  final ArticleEntity ? article;
  ArticleRemovedEvent(this.article);
}