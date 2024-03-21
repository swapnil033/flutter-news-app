import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/provider/article/local/local_article_provider_state.dart';

import '../../../../../../injection_container.dart';
import '../../../../domain/usecases/delete_article.dart';
import '../../../../domain/usecases/get_saved_article.dart';
import '../../../../domain/usecases/save_article.dart';

class LocalArticleNotifier
    extends StateNotifier<LocalArticleProviderState<List<ArticleEntity>>> {
  final GetSavedArticleUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  LocalArticleNotifier(
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._deleteArticleUseCase,
  ) : super(LocalArticleProviderState.loading()) {
    getList();
  }

  Future<void> getList() async {
    var list = await _getSavedArticlesUseCase();

    state = LocalArticleProviderState.success(list);
  }

  Future<void> saveArticle(ArticleEntity articleEntity) async {
    await _saveArticleUseCase(params: articleEntity);

    var list = await _getSavedArticlesUseCase();

    state = LocalArticleProviderState.success(list);
  }

  Future<void> deleteArticle(ArticleEntity articleEntity) async {
    await _deleteArticleUseCase(params: articleEntity);

    var list = await _getSavedArticlesUseCase();

    state = LocalArticleProviderState.success(list);
  }
}

final localArticlesProvider = StateNotifierProvider<LocalArticleNotifier,
    LocalArticleProviderState<List<ArticleEntity>>>((ref) {
  return LocalArticleNotifier(sl(), sl(), sl());
});
