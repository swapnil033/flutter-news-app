import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService newsApiService;
  final AppDatabase database;

  ArticleRepositoryImpl(this.newsApiService, this.database);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await newsApiService.getNewsArticles(
        apiKey: kApiKey,
        sources: kSource,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      print(e.message);
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity articleEntity) {
    return database.articleDao
        .deleteArticle(ArticleModel.fromEntity(articleEntity));
  }

  @override
  Future<List<ArticleModel>> getArticles() {
    return database.articleDao.getArticles();
  }

  @override
  Future<void> insertArticle(ArticleEntity articleEntity) {
    return database.articleDao
        .insertArticle(ArticleModel.fromEntity(articleEntity));
  }
}
