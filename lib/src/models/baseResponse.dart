class BaseResponse<T> {
  final String status;
  final String? error;
  final T? data;

  BaseResponse({required this.status, this.error, this.data});

  bool get hasError => (error != null) || (data == null);

  // bool get hasData => data != null;
}
