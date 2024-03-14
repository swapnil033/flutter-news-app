import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  // API methods
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  //DataBase

  Future<void> insertArticle(ArticleEntity articleEntity);

  Future<void> deleteArticle(ArticleEntity articleEntity);

  Future<List<ArticleEntity>> getArticles();
}
