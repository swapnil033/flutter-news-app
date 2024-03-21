sealed class RemoteArticleProviderState<T> {
  const RemoteArticleProviderState._();

  factory RemoteArticleProviderState.success(T data) = Success<T>;
  factory RemoteArticleProviderState.error(String message) = Error<T>;
  factory RemoteArticleProviderState.loading() = Loading<T>;
}

class Success<T> extends RemoteArticleProviderState<T> {
  final T data;

  const Success(this.data) : super._();
}

class Error<T> extends RemoteArticleProviderState<T> {
  final String message;

  const Error(this.message) : super._();
}

class Loading<T> extends RemoteArticleProviderState<T> {
  const Loading() : super._();
}
