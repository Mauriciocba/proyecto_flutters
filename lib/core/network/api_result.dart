enum ResultType { success, failure, error }

class ApiResult {
  final ResultType resultType;
  final int? statusCode;
  final Map<String, dynamic>? body;

  ApiResult.success({
    this.resultType = ResultType.success,
    this.body,
    this.statusCode,
  });

  ApiResult.failure({
    this.resultType = ResultType.failure,
    this.body,
    this.statusCode,
  });

  ApiResult.error({
    this.resultType = ResultType.error,
    this.body,
    this.statusCode,
  });
}
