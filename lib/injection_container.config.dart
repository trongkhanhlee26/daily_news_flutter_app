// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/daily_news/data/data_sources/remote/news_api_service.dart'
    as _i468;
import 'features/daily_news/data/repository/article_repository_impl.dart'
    as _i781;
import 'features/daily_news/domain/repository/article_repository.dart' as _i532;
import 'features/daily_news/domain/usecase/get_article.dart' as _i879;
import 'features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart'
    as _i452;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i468.NewsApiService>(
        () => registerModule.newsApiService(gh<_i361.Dio>()));
    gh.singleton<_i532.ArticleRepository>(
        () => _i781.ArticleRepositoryImpl(gh<_i468.NewsApiService>()));
    gh.singleton<_i879.GetArticleUseCase>(
        () => _i879.GetArticleUseCase(gh<_i532.ArticleRepository>()));
    gh.factory<_i452.RemoteArticleBloc>(
        () => _i452.RemoteArticleBloc(gh<_i879.GetArticleUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
