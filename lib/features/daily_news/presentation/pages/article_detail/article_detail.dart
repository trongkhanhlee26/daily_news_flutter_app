import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_1/features/daily_news/domain/entities/article.dart';
import 'package:flutter_1/features/daily_news/domain/usecase/save_article.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
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
      create: (_) => s1<LocalArticleBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: floatingActionButton(),
      ),
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
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        article!.urlToImage!,
        fit: BoxFit.cover,
      ),
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

  Widget floatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => onFloatingActionButtonPressed(context),
        child: const Icon(Ionicons.bookmark, color: Colors.white),
      ),  
    );
  }

  void onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Article saved to favorites'),
          backgroundColor: Colors.black,
        ),
      );
  }
}