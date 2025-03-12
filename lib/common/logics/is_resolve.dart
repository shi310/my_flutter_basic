import 'package:dio/dio.dart';

bool isResolve(DioException err) {
  final exceptions = [
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.badResponse,
    DioExceptionType.connectionError,
  ];
  return exceptions.contains(err.type);
}