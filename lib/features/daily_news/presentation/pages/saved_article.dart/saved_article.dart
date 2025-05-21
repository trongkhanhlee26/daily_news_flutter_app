import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/core/events/article_events.dart';
import 'package:flutter_1/features/daily_news/data/models/article.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_1/features/daily_news/presentation/wigdets/article_tile.dart';
import 'package:flutter_1/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../bloc/article/local/local_article_event.dart';

class SavedArticles extends HookWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
    final subscription = eventBus.on<ArticleSavedEvent>().listen((event) {
      BlocProvider.of<LocalArticleBloc>(context).add(const GetSavedArticles());
    });
    return subscription.cancel;
  }, []);
    return BlocProvider(create: (_) => 
      s1<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: Scaffold(
        appBar: _buildAppBar(),        
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onBackButtonTapped(context),
        child: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      ),
      title: const Text('Saved Articles', style: TextStyle(color: Colors.black,)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalArticleDone) {
          return _buildArticleList(state.articles!);
        }
        return Container();
      },
    );
  }

  Widget _buildArticleList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(child: Text('No saved articles', style: TextStyle(color: Colors.black),));
    }
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => onRemoveArticle(context, article),
          onArticlePressed: (article) => onArticlePressed(context, article),
        );
      },
      cacheExtent: 500,
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void onRemoveArticle(BuildContext context, ArticleEntity article) {
    BlocProvider.of<LocalArticleBloc>(context).add(RemoveArticle(article));
  }

  void onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}