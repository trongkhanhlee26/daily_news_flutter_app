import 'package:flutter/material.dart';
import 'package:flutter_1/config/theme/app_themes.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_1/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_1/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:flutter_1/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // await initializeDependencies();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => s1()..add(const GetRemoteArticleEvent()),
      child: MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        home: DailyNews(),
      ),
    );
  }
}
