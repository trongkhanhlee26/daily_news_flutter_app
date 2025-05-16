import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_1/features/daily_news/data/data_sources/remote/news_api_service.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => Dio();

  @singleton
  NewsApiService newsApiService(Dio dio) => NewsApiService(dio);
}
