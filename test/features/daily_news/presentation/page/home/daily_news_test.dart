import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/pages/home/daily_news.dart';

class MockRemoteArticlesBloc
    extends MockBloc<RemoteArticlesEvent, RemoteArticleState>
    implements RemoteArticlesBloc {}

void main() {
  late MockRemoteArticlesBloc mockRemoteArticlesBloc;

  setUp(() {
    mockRemoteArticlesBloc = MockRemoteArticlesBloc();
    HttpOverrides.global = null;
  });

  const testArticle = ArticleEntity(
    author: 'Lauren Forristal',
    title:
        'Bye-bye bots: Altera\'s game-playing AI agents get backing from Eric Schmidt | TechCrunch',
    description:
        'Autonomous, AI-based players are coming to a gaming experience near you, and a new startup, Altera, is joining the fray to build this new guard of AI Research company Altera raised \$9 million to build AI agents that can play video games alongside other player…',
    url:
        'https://techcrunch.com/2024/05/08/bye-bye-bots-alteras-game-playing-ai-agents-get-backing-from-eric-schmidt/',
    urlToImage:
        'https://techcrunch.com/wp-content/uploads/2024/05/Minecraft-keyart.jpg?resize=1200,720',
    publishedAt: '2024-05-08T15:14:57Z',
    content:
        'Autonomous, AI-based players are coming to a gaming experience near you, and a new startup, Altera, is joining the fray to build this new guard of AI agents.\r\nThe company announced Wednesday that it … [+6416 chars]',
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => mockRemoteArticlesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should be loading state',
    (widgetTester) async {
      //arrange
      when(() => mockRemoteArticlesBloc.state)
          .thenAnswer((invocation) => const RemoteArticlesLoading());

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const DailyNews()));
      var loading = find.byType(CupertinoActivityIndicator);

      await widgetTester.pump();

      //assert
      expect(loading, findsOneWidget);
    },
  );

  testWidgets(
    'should be loaded news',
    (widgetTester) async {
      //arrange
      when(() => mockRemoteArticlesBloc.state)
          .thenAnswer((invocation) => const RemoteArticlesDone([testArticle]));

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const DailyNews()));
      var newsList = find.byKey(const Key('news_data'));

      await widgetTester.pump();

      //assert
      expect(newsList, findsOneWidget);
    },
  );
  var dioError = DioError(
      error: 'error',
      type: DioErrorType.response,
      requestOptions: RequestOptions(path: ''));

  testWidgets(
    'should be error text visible',
    (widgetTester) async {
      //arrange
      when(() => mockRemoteArticlesBloc.state)
          .thenAnswer((invocation) => RemoteArticlesError(dioError));

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const DailyNews()));
      var newsList = find.byKey(const Key('api_error'));

      await widgetTester.pump();

      //assert
      expect(newsList, findsOneWidget);
    },
  );
}
