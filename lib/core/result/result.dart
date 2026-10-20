/// Outcome of a repository call: either [Success] with data or [Failure] with a message.
sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

final class Failure<T> extends Result<T> {
  const Failure(this.message);
  final String message;
}
