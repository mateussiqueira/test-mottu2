/// A class that represents the result of an operation that can either succeed with a value of type [T]
/// or fail with an error message.
class Result<T> {
  final T? _data;
  final String? _error;
  final bool _isSuccess;

  Result._(this._data, this._error, this._isSuccess);

  /// Creates a successful result with the given [data].
  factory Result.success(T data) => Result._(data, null, true);

  /// Creates a failed result with the given [error] message.
  factory Result.failure(String error) => Result._(null, error, false);

  /// Whether this result represents a successful operation.
  bool get isSuccess => _isSuccess;

  /// Whether this result represents a failed operation.
  bool get isFailure => !_isSuccess;

  /// The data of this result, if it represents a successful operation.
  T? get data => _data;

  /// The error message of this result, if it represents a failed operation.
  String? get error => _error;

  /// Maps this result to a new result with a different type [U] using the given [transform] function.
  Result<U> map<U>(U Function(T data) transform) {
    if (isSuccess && _data != null) {
      return Result.success(transform(_data as T));
    }
    return Result.failure(_error ?? 'Unknown error');
  }

  /// Returns the result of calling [onSuccess] with the data if this result is successful,
  /// or [onFailure] with the error message if this result is a failure.
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(String error) onFailure,
  ) {
    if (isSuccess && _data != null) {
      return onSuccess(_data as T);
    }
    return onFailure(_error ?? 'Unknown error');
  }
}
