class Result<T> {
  final T? data;
  final dynamic error;
  final bool isSuccess;

  Result._({
    this.data,
    this.error,
    required this.isSuccess,
  });

  factory Result.success(T data) {
    return Result._(
      data: data,
      isSuccess: true,
    );
  }

  factory Result.failure(dynamic error) {
    return Result._(
      error: error,
      isSuccess: false,
    );
  }

  bool get isFailure => !isSuccess;

  @override
  String toString() {
    return 'Result{data: $data, error: $error, isSuccess: $isSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Result<T> &&
        other.data == data &&
        other.error == error &&
        other.isSuccess == isSuccess;
  }

  @override
  int get hashCode => data.hashCode ^ error.hashCode ^ isSuccess.hashCode;

  T getOrThrow() {
    if (isSuccess) {
      return data!;
    }
    throw error;
  }

  T? getOrNull() {
    return data;
  }

  T getOrDefault(T defaultValue) {
    return data ?? defaultValue;
  }
}
