import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel articleModel);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticles();
}
