import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

@GenerateMocks([
  ArticleRepository,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
