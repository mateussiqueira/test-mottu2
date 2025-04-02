class Result<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  Result({
    this.data,
    this.error,
    required this.isSuccess,
  });

  factory Result.success(T data) {
    return Result(
      data: data,
      isSuccess: true,
    );
  }

  factory Result.failure(String error) {
    return Result(
      error: error,
      isSuccess: false,
    );
  }
}
