sealed class LocalArticleProviderState<T> {
  const LocalArticleProviderState._();

  factory LocalArticleProviderState.success(T data) = Success<T>;
  factory LocalArticleProviderState.loading() = Loading<T>;
}

class Success<T> extends LocalArticleProviderState<T> {
  final T data;

  const Success(this.data) : super._();
}

class Loading<T> extends LocalArticleProviderState<T> {
  const Loading() : super._();
}
