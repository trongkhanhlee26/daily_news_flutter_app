import 'package:flutter_1/core/resources/data_state.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}