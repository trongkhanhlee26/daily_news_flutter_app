import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_1/core/resources/data_state.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import '../../../../domain/usecase/get_article.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState>{
  final GetArticleUseCase _getArticleUseCase;
  
  RemoteArticleBloc(this._getArticleUseCase) : super(const RemoteArticleLoading()){
    on<GetRemoteArticleEvent>(onGetArticle);
  }
  
  void onGetArticle(GetRemoteArticleEvent event, Emitter<RemoteArticleState> emit) async{
    final dataState = await _getArticleUseCase.call(NoParams());

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleSuccess(dataState.data!));
    } else if (dataState is DataError) {
      print(dataState.error!.message);
      emit(RemoteArticleError(dataState.error!));
    } else {
      emit(const RemoteArticleLoading());
    }
  }
}