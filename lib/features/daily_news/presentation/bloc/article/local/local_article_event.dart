import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticlesEvent extends Equatable {
  final ArticleEntity? article;

  const LocalArticlesEvent({this.article});

  @override
  List<Object?> get props => [article!];
}

class GetSavedArticles extends LocalArticlesEvent {
  const GetSavedArticles();
}

class SavedArticles extends LocalArticlesEvent {
  const SavedArticles(ArticleEntity article) : super(article: article);
}

class RemoveArticles extends LocalArticlesEvent {
  const RemoveArticles(ArticleEntity article) : super(article: article);
}
