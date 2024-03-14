import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class DeleteArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository articleRepository;

  DeleteArticleUseCase(this.articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return articleRepository.deleteArticle(params!);
  }
}
