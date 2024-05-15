import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../../../../helper/test_helper.mocks.dart';

void main() {
  late MockGetArticleUseCase mockGetArticleUseCase;
  late RemoteArticlesBloc remoteArticlesBloc;

  setUp(() {
    mockGetArticleUseCase = MockGetArticleUseCase();
    remoteArticlesBloc = RemoteArticlesBloc(mockGetArticleUseCase);
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

  test(
    'initial state should be loading',
    () async {
      //arrange

      //act

      //assert
      expect(remoteArticlesBloc.state, const RemoteArticlesLoading());
    },
  );

  blocTest(
    'should emit loading, successful when data is received',
    build: () {
      when(mockGetArticleUseCase()).thenAnswer(
          (realInvocation) async => const DataSuccess([testArticle]));

      return remoteArticlesBloc;
    },
    act: (bloc) => bloc.add(const GetArticles()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const RemoteArticlesLoading(),
      const RemoteArticlesDone([testArticle]),
    ],
  );

  var dioError = DioError(
      error: 'error',
      type: DioErrorType.response,
      requestOptions: RequestOptions(path: ''));

  blocTest(
    'should emit loading, error when data is not received',
    build: () {
      when(mockGetArticleUseCase())
          .thenAnswer((realInvocation) async => DataFailed(dioError));

      return remoteArticlesBloc;
    },
    act: (bloc) => bloc.add(const GetArticles()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const RemoteArticlesLoading(),
      RemoteArticlesError(dioError),
    ],
  );
}
