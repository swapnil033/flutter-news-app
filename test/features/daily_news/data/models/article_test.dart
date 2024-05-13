import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

import '../../../../helper/json_reader.dart';

void main() {
  const testArticle = ArticleModel(
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
    'should be subclass of ArticleEntity',
    () async {
      //arrange

      //act

      //assert
      expect(testArticle, isA<ArticleEntity>());
    },
  );

  test(
    'should return valid model from json',
    () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('helper/dummy_data/article_list.json'));

      //act
      var result = ArticleModel.fromJson(jsonMap);

      //assert
      expect(result, equals(testArticle));
    },
  );

  test(
    'should return valid entity from model',
    () async {
      //arrange

      //act
      var result = ArticleModel.fromEntity(testArticle);

      //assert
      expect(result, isA<ArticleEntity>());
    },
  );
}
