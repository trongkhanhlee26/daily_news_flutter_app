import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_1/features/daily_news/presentation/wigdets/article_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      
      title: const Text('Daily News', style: TextStyle(color: Colors.black,)),
      actions: [
        GestureDetector(
          onTap: () => onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.bookmark, color: Colors.black),
            ),
        ),
      ],
    );
  }

  _body(BuildContext context){
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CircularProgressIndicator());
        } 
        if (state is RemoteArticleError) {
          return Center(child: Text('Error: ${state.error}'));
        } 
        if (state is RemoteArticleSuccess) {
          return ListView.builder(
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () => _onArticlePressed(context, state.articles![index]),
                child: ArticleWidget(
                  article: state.articles![index],
                  isRemovable: true,
                  onRemove: (article) => onRemoveArticle(context, article),
                  onArticlePressed: (article) => onArticlePressed(context, article),
                ),
              );
            },
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }

  void onRemoveArticle(BuildContext context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
  }

  void onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}