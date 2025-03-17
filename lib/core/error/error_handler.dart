import 'package:dio/dio.dart';

import '../../config/constants/app_constants.dart';

/// An enum that holds names for our custom exceptions.
enum ExceptionType {
  /// The exception for an expired bearer token.
  TokenExpiredException,

  /// The exception for a prematurely cancelled request.
  CancelException,

  /// The exception for a failed connection attempt.
  ConnectTimeoutException,

  /// The exception for failing to send a request.
  SendTimeoutException,

  /// The exception for failing to receive a response.
  ReceiveTimeoutException,

  /// The exception for no internet connectivity.
  SocketException,

  /// A better name for the socket exception.
  FetchDataException,

  /// The exception for an incorrect parameter in a request/response.
  FormatException,

  /// The exception for an unknown type of failure.
  UnrecognizedException,

  /// The exception for an unknown exception from the api.
  ApiException,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  SerializationException,

  BadCertificateException,

  UnknownPhoneException,
}

class CustomDioInterceptor extends Interceptor {
  // final Connectivity connectivity = Connectivity();

  CustomDioInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    printDebug("Request sent: ${options.method} ${options.path}");
    // var connectivityResult = await Connectivity().checkConnectivity();
    // if (connectivityResult.contains(ConnectivityResult.none)) {
    //   throw ErrorHandler(
    //       errorMessage: "No internet connection",
    //       exceptionType: ExceptionType.SocketException);
    // }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printDebug(
        "Response received: ${response.statusCode} ${response.statusMessage}  ${response.realUri}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    printDebug("Response received: ${err.message} ${err.type} ");
    return super.onError(err, handler);
  }
}

class ErrorHandler implements Exception {
  // late String message;
  final String name, errorMessage;
  final String? code;
  final int? statusCode;
  final ExceptionType exceptionType;

  //ErrorHandler(this.message);
  ErrorHandler({
    this.code,
    int? statusCode,
    required this.errorMessage,
    this.exceptionType = ExceptionType.ApiException,
  })  : statusCode = statusCode ?? 500,
        name = exceptionType.name;

  factory ErrorHandler.fromDioException(Exception error) {
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            return ErrorHandler(
              exceptionType: ExceptionType.CancelException,
              statusCode: error.response?.statusCode,
              errorMessage: 'Request cancelled prematurely',
            );
          case DioExceptionType.connectionError:
            return ErrorHandler(
              exceptionType: ExceptionType.ConnectTimeoutException,
              statusCode: error.response?.statusCode,
              errorMessage: 'Connection Error',
            );
          case DioExceptionType.connectionTimeout:
            return ErrorHandler(
              exceptionType: ExceptionType.ConnectTimeoutException,
              statusCode: error.response?.statusCode,
              errorMessage: 'Timed out',
            );
          case DioExceptionType.sendTimeout:
            return ErrorHandler(
              exceptionType: ExceptionType.SendTimeoutException,
              statusCode: error.response?.statusCode,
              errorMessage: 'Failed to send',
            );
          case DioExceptionType.receiveTimeout:
            return ErrorHandler(
              exceptionType: ExceptionType.ReceiveTimeoutException,
              statusCode: error.response?.statusCode,
              errorMessage: 'Timed out',
            );
          case DioExceptionType.badResponse:
          case DioExceptionType.unknown:
            if (error.message == ExceptionType.SocketException.name) {
              return ErrorHandler(
                exceptionType: ExceptionType.FetchDataException,
                statusCode: error.response?.statusCode,
                errorMessage: 'No internet connectivity',
              );
            }
            if (error.response?.data != null) {
              return ErrorHandler(
                exceptionType: ExceptionType.UnrecognizedException,
                statusCode: error.response?.statusCode,
                errorMessage: error.response?.data ?? 'Bad Response',
              );
            }

            if (error.response?.data['headers']['code'] == null) {
              return ErrorHandler(
                exceptionType: ExceptionType.UnrecognizedException,
                statusCode: error.response?.statusCode,
                errorMessage: error.response?.statusMessage ?? 'Network Err',
              );
            }
            final name = error.response?.data['headers']['code'] as String;
            final message =
                error.response?.data['headers']['message'] as String;
            if (name == ExceptionType.TokenExpiredException.name) {
              return ErrorHandler(
                exceptionType: ExceptionType.TokenExpiredException,
                code: name,
                statusCode: error.response?.statusCode,
                errorMessage: message,
              );
            }
            return ErrorHandler(
              errorMessage: message,
              code: name,
              statusCode: error.response?.statusCode,
            );
          case DioExceptionType.badCertificate:
            return ErrorHandler(
              exceptionType: ExceptionType.BadCertificateException,
              statusCode: error.response?.statusCode,
              errorMessage: 'Bad Certificate',
            );
        }
      } else {
        return ErrorHandler(
          exceptionType: ExceptionType.UnrecognizedException,
          errorMessage: 'Error unrecognized',
        );
      }
    } on Exception catch (_) {
      return ErrorHandler(
        exceptionType: ExceptionType.UnrecognizedException,
        errorMessage: 'Error unrecognized',
      );
    }
  }
}
