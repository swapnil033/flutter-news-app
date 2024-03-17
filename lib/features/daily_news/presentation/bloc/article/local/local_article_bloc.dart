import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/usecases/delete_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent, LocalArticleState> {
  final GetSavedArticleUseCase getSavedArticlesUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  final DeleteArticleUseCase deleteArticleUseCase;

  LocalArticleBloc(
    this.getSavedArticlesUseCase,
    this.saveArticleUseCase,
    this.deleteArticleUseCase,
  ) : super(const LocalArticleLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticles>(onDeleteArticles);
    on<SavedArticles>(onSaveArticles);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onSaveArticles(
      SavedArticles article, Emitter<LocalArticleState> emit) async {
    await saveArticleUseCase(params: article.article);
    final articles = await getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onDeleteArticles(
      RemoveArticles article, Emitter<LocalArticleState> emit) async {
    await deleteArticleUseCase(params: article.article);
    final articles = await getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }
}
