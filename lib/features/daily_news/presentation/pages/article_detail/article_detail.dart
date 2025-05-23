import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/core/events/article_events.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_1/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

class ArticleDetailView extends HookWidget {
  final ArticleEntity ? article;
  
  const ArticleDetailView({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (_) => s1<LocalArticleBloc>()..add(const GetSavedArticles()),
      child: BlocBuilder<LocalArticleBloc, LocalArticleState>(builder: (context, state) {
        bool isSaved = false;
        if(state is LocalArticleDone){
          isSaved = state.articles!.any((a) => a.url != null && a.url == article?.url);
        }
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          floatingActionButton: floatingActionButton(isSaved, context),
        );  
      }
    )
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onBackButtonTapped(context),
        child: const Icon(Ionicons.chevron_back, color: Colors.black),
      ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildArticleTitleAndDate(),
          buildArticleImage(),
          buildArticleDescription(),
        ],
      ),
    );
  }

  Widget buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article!.title!,
            style: const TextStyle(fontFamily:'Butler', fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                article!.publishedAt!,
                style: const TextStyle (fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildArticleImage() {
    final imageUrl = article?.urlToImage;
    final imageWidget = imageUrl == null || imageUrl.isEmpty
        ? const Icon(Icons.image, size: 40, color: Colors.grey)
        : CachedNetworkImage(
            imageUrl: imageUrl,
            fadeInDuration: Duration.zero,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                ),
            ),
            progressIndicatorBuilder: (context, url, progress) =>
                const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          );
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: imageWidget,
    );
  }

  Widget buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: Text(
        '${article!.description ?? ''}\n\n${article!.content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget floatingActionButton(bool isSaved, BuildContext context) {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: isSaved ? null : () => onFloatingActionButtonPressed(context),
        backgroundColor: isSaved ? Colors.grey : Theme.of(context).primaryColor,
        child: Icon(isSaved ? Ionicons.bookmark : Ionicons.bookmark_outline,
        color: Colors.white,
        ),
      ),
    );
  }

  void onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    eventBus.fire(ArticleSavedEvent(article!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article saved to favorites'),
          backgroundColor: Colors.black,
        ),
      );
  }
}