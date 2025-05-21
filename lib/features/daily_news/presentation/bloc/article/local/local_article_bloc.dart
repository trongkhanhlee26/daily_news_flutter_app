import 'package:bloc/bloc.dart';
import 'package:flutter_1/features/daily_news/domain/usecase/get_saved_article.dart';
import 'package:flutter_1/features/daily_news/domain/usecase/remove_article.dart';
import 'package:flutter_1/features/daily_news/domain/usecase/save_article.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_state.dart';


class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState>{
  final GetSavedArticleUseCase getSavedArticlesUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  final RemoveArticleUseCase removeArticleUseCase;

  LocalArticleBloc(this.getSavedArticlesUseCase, this.saveArticleUseCase, this.removeArticleUseCase) : super(const LocalArticleLoading()){
    on<GetSavedArticles> (onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  void onGetSavedArticles (GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    emit(const LocalArticleLoading());
    try {
      final articles = await getSavedArticlesUseCase();
      emit(LocalArticleDone(articles));
    } catch (e) {
      emit(const LocalArticleDone([]));
    }
  }

  void onRemoveArticle(RemoveArticle event, Emitter<LocalArticleState> emit) async {
    emit(const LocalArticleLoading());
    try {
      await removeArticleUseCase(params: event.article);
      final articles = await getSavedArticlesUseCase();
      emit(LocalArticleDone(articles));
    } catch (e) {
      emit(const LocalArticleDone([]));
    }
  }

  void onSaveArticle(SaveArticle event, Emitter<LocalArticleState> emit) async {
    emit(const LocalArticleLoading());
    try {
      await saveArticleUseCase(params: event.article);
      final articles = await getSavedArticlesUseCase();
      emit(LocalArticleDone(articles));
    } catch (e) {
      emit(const LocalArticleDone([]));
    }
  }

  
}

