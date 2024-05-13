import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockArticleRepository mockArticleRepository;
  late GetArticleUseCase getArticleUseCase;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    getArticleUseCase = GetArticleUseCase(mockArticleRepository);
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
    'should get articles from api',
    () async {
      //arrange
      when(mockArticleRepository.getNewsArticles()).thenAnswer(
          (realInvocation) async => const DataSuccess([testArticle]));

      //act
      var result = await getArticleUseCase();

      //assert
      expect(result, equals(const DataSuccess([testArticle])));
    },
  );
}
