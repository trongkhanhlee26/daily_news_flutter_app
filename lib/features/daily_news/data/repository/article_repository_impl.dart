import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_1/core/constants/constants.dart';
import 'package:flutter_1/core/resources/data_state.dart';
import 'package:flutter_1/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_1/features/daily_news/data/models/article.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';
import 'package:flutter_1/features/daily_news/domain/repository/article_repository.dart';
import 'package:retrofit/dio.dart';

abstract class ArticleRepositoryImpl implements ArticleRepository{
  final NewsApiService _newsApiService;
  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async{
    try{
      final HttpResponse = await _newsApiService.getNewsArticles(
        country: country,
        apiKey: newsApiKey,
        category: category,
      );

      if (HttpResponse.response.statusCode == HttpStatus.ok) {
        final articles = HttpResponse.data;
        return DataSuccess(articles);
      } else {
        return DataError(
          DioException(
            requestOptions: HttpResponse.response.requestOptions,
            response: HttpResponse.response,
            type: DioExceptionType.badResponse,
            error: 'Failed to fetch articles',           
          )
        );
      }
    }on DioException catch (e) {
      return DataError(e);
    }  
  }
}

extension on HttpResponse<List<ArticleModel>> {
  get request => null;
}