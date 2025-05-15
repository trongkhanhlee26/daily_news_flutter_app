import 'package:flutter/material.dart';
import 'package:flutter_1/config/theme/app_themes.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_1/features/daily_news/presentation/wigdets/article_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      
      title: const Text('Daily News', style: TextStyle(color: Colors.black,)),
    );
  }

  _body(){
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RemoteArticleSuccess) {
          return ListView.builder(
            itemBuilder: (context, index){
              return ArticleWidget(
                article: state.articles![index],
              );
            },
            itemCount: state.articles!.length,
          );
        } else if (state is RemoteArticleError) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const Center(child: Text('No articles found.'));
      },
    );
  }
}