import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/provider/article/remote/remote_articles_provider_state.dart';
import 'package:news_app/injection_container.dart';

class RemoteArticleNotifier
    extends StateNotifier<RemoteArticleProviderState<List<ArticleEntity>?>> {
  final GetArticleUseCase _articleUseCase;

  RemoteArticleNotifier(this._articleUseCase)
      : super(RemoteArticleProviderState.loading()) {
    getList();
  }

  Future<void> getList() async {
    var list = await _articleUseCase();

    state = RemoteArticleProviderState.success(list.data);
  }
}

final remoteArticlesProvider = StateNotifierProvider<RemoteArticleNotifier,
    RemoteArticleProviderState<List<ArticleEntity>?>>((ref) => sl());
