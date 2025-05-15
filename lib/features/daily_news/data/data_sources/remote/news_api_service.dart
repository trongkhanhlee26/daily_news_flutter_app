import 'package:dio/dio.dart';
import 'package:flutter_1/core/constants/constants.dart';
import 'package:flutter_1/features/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;
  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('country') String ? country,
    @Query('apiKey') String ? apiKey,
    @Query('category') String ? category,
  });
}