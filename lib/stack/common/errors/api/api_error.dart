import 'package:dio/dio.dart';

import '../../exceptions/invalid_response_exception.dart';
import '../../exceptions/network_unavailable_exception.dart';
import '../../models/failure.dart';
import 'api_error_type.dart';

class ApiError extends Failure {
  const ApiError._internal({
    required this.errorType,
    required super.message,
  });

  /// Api error type generated out of api failures.
  final ApiErrorType errorType;

  factory ApiError.fromException(Exception e) {
    return ApiError._internal(
      errorType: _getErrorType(e),
      message: _getErrorMessage(e),
    );
  }

  @override
  String toString() => message;

  // Helpers
  static ApiErrorType _getErrorType(Exception ex) {
    if (ex is DioException) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        return ApiErrorType.connectionTimeout;
      } else if (ex.type == DioExceptionType.sendTimeout) {
        return ApiErrorType.requestTimeout;
      } else if (ex.type == DioExceptionType.receiveTimeout) {
        return ApiErrorType.responseTimeout;
      } else if (ex.type == DioExceptionType.connectionError) {
        return ApiErrorType.connectionError;
      } else if (ex.type == DioExceptionType.cancel) {
        return ApiErrorType.operationCanceled;
      } else if (ex.type == DioExceptionType.badCertificate) {
        return ApiErrorType.badCertificate;
      } else if (ex.type == DioExceptionType.badResponse) {
        return _getErrorTypeFromResponse(ex.response!);
      }
    } else if (ex is NetworkUnavailableException) {
      return ApiErrorType.networkUnavailable;
    } else if (ex is InvalidResponseException) {
      return ApiErrorType.invalidResponse;
    }
    return ApiErrorType.unspecified;
  }

  static String _getErrorMessage(Exception ex) {
    var msg = '';
    if (ex is DioException) {
      msg += _getErrorStringFromType(ex.type);

      if (ex.response?.statusMessage != null) {
        msg += '${ex.response?.statusMessage} - ';
      }
      if (ex.message != null) msg += ex.message!;

      if (ex.response?.data is Map<String, dynamic>?) {
        final responseData = ex.response?.data as Map<String, dynamic>?;
        if (responseData != null &&
            responseData.containsKey('status_message')) {
          msg += '\n${responseData['status_message']}';
        }
      }
    } else {
      msg = ex.toString();
    }
    return msg;
  }

  static ApiErrorType _getErrorTypeFromResponse(Response<dynamic> response) {
    final statusCode = response.statusCode;
    if (statusCode == null) return ApiErrorType.unspecified;
    // Map client & server error responses.
    if (statusCode >= 400 && statusCode < 500) {
      switch (statusCode) {
        case 400:
          return ApiErrorType.badRequest;
        case 401:
          return ApiErrorType.unauthorized;
        case 403:
          return ApiErrorType.forbidden;
        case 404:
          return ApiErrorType.notFound;
        case 405:
          return ApiErrorType.methodNotAllowed;
        case 406:
          return ApiErrorType.notAcceptable;
        case 408:
          return ApiErrorType.requestTimeout;
        case 409:
          return ApiErrorType.conflict;
        case 412:
          return ApiErrorType.preconditionFailed;
      }
    } else if (statusCode >= 500 && statusCode < 600) {
      return ApiErrorType.serverError;
    }
    return ApiErrorType.unspecified;
  }

  static String _getErrorStringFromType(DioExceptionType errorType) {
    switch (errorType) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out.\n';
      case DioExceptionType.sendTimeout:
        return 'Request timed out.\n';
      case DioExceptionType.receiveTimeout:
        return 'Response timed out.\n';
      case DioExceptionType.connectionError:
        return 'Connection error occurred.\n';
      case DioExceptionType.cancel:
        return 'Operation canceled.\n';
      case DioExceptionType.badResponse:
      case DioExceptionType.badCertificate:
        return 'Request completed with a status error.\n';
      case DioExceptionType.unknown:
        return 'Unexpected error occurred.\n';
    }
  }
  // - Helpers
}
