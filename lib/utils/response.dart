class CustomResponse<T> {
  final T value;
  final String? error;
  final bool hasError;

  CustomResponse({
    required this.value,
    this.error,
  }) : hasError = error?.isNotEmpty ?? false;
}
