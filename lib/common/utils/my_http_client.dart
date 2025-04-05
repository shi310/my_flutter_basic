import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class MyHttpClient {
  MyHttpClient({
    required this.urls,
    this.headers,
    this.onResponse,
    this.onConnectError,
    this.code = 200,
    this.timeout = const Duration(seconds: 5),
  }) {
    if (isInitialized) {
      log("⚠️ MyGetConnect 已经初始化...");
      return;
    }

    _httpClient = GetHttpClient();

    _httpClient?.baseUrl = urls.first;
    _httpClient?.timeout = timeout;

    _httpClient?.addAuthenticator<void>((request) async {
      request.headers.addAll(headers!);
      return request;
    });

    _httpClient?.addResponseModifier((request, response) async {
      await onResponse?.call(request, response);
      return response;
    });
  }

  List<String> urls;
  Map<String, String>? headers;
  final Future<void> Function(Request<Object?> request, Response<Object?> response)? onResponse;
  final Future<dynamic> Function(Response<dynamic>?)? onConnectError;
  final int code;
  final Duration timeout;

  GetHttpClient? _httpClient;
  bool get isInitialized => _httpClient != null;

  // index
  int _index = 0;

  // 连接过的 url 数量
  int _urlCount = 0;

  void close() {
    _httpClient?.close();
    _httpClient = null;
  }

  void clearUrlCount() {
    _urlCount = 0;
  }

  void _logConnectError(Response? response) {
    String headers = const JsonEncoder.withIndent('  ').convert(response?.request?.headers);
    String parameters = const JsonEncoder.withIndent('  ').convert(response?.request?.url.queryParameters);

    log("❌" * 80);
    log("❌ 请求地址 => ${response?.request?.url.scheme}://${response?.request?.url.host}${response?.request?.url.path}");
    log("❌ 请求方式 => ${response?.request?.method}");
    log("❌ 请求头 => $headers");
    log("❌ 请求参数 => $parameters");
    log("❌ 错误信息 => ${response?.statusText}");
    log("❌" * 80);
  }

  void _logError(Response? response) {
    String headers = const JsonEncoder.withIndent('  ').convert(response?.request?.headers);
    String parameters = const JsonEncoder.withIndent('  ').convert(response?.request?.url.queryParameters);

    log("⚠️" * 80);
    log("⚠️ 请求地址 => ${response?.request?.url.scheme}://${response?.request?.url.host}${response?.request?.url.path}");
    log("⚠️ 请求方式 => ${response?.request?.method}");
    log("⚠️ 请求头 => $headers");
    log("⚠️ 请求参数 => $parameters");
    log("⚠️ 错误信息 => ${response?.statusText}");
    log("⚠️" * 80);
  }

  void _logSuccess(Response? response) {
    String headers = const JsonEncoder.withIndent('  ').convert(response?.request?.headers);
    String parameters = const JsonEncoder.withIndent('  ').convert(response?.request?.url.queryParameters);
    String data = const JsonEncoder.withIndent('  ').convert(json.decode(response?.bodyString ?? ''));

    log("✅" * 80);
    log("✅ 请求地址 => ${response?.request?.url.scheme}://${response?.request?.url.host}${response?.request?.url.path}");
    log("✅ 请求方式 => ${response?.request?.method}");
    log("✅ 请求头 => $headers");
    log("✅ 请求参数 => $parameters");
    log("✅ 返回数据 => $data");
    log("✅" * 80);
  }

  Future<void> get<T>(String path, {
    Future<dynamic> Function(int, String, T)? onSuccess,
    Map<String, dynamic>? data,
    Future<dynamic> Function(Response<dynamic>?)? onError,
    T Function(dynamic)? onModel,
  }) async {
    final response = await _httpClient?.get(path, query: data);

    if (response != null && response.isOk ) {
      _urlCount = 0;

      final responseModel = ResponseModel.fromJson( json.decode(response.bodyString ?? '{}'));
      if (responseModel.code == code) {
        _logSuccess(response);
        final model = onModel != null ? onModel(responseModel.data) : responseModel.data as T;
        await onSuccess?.call(responseModel.code, responseModel.msg, model);
        return;
      } else {
        _logError(response);
        await onError?.call(response);
        return;
      }
    } else {
      _logConnectError(response);
      _urlCount++;

      if (_urlCount < urls.length) {
        _index = (_index + 1) % urls.length;
        _httpClient?.baseUrl = urls[_index];
        get<T>(path, data: data, onSuccess: onSuccess, onError: onError, onModel: onModel);
        return;
      }
    }

    await onConnectError?.call(response);
    clearUrlCount();
  }

  Future<void> post<T>(String path, {
    Future<dynamic> Function(int, String, T)? onSuccess,
    Map<String, dynamic>? data,
    Future<dynamic> Function(Response<dynamic>?)? onError,
    T Function(dynamic)? onModel,
  }) async {
    final response = await _httpClient?.post(path, body: data);

    if (response != null && response.isOk ) {
      _urlCount = 0;

      final responseModel = ResponseModel.fromJson( json.decode(response.bodyString ?? '{}'));
      if (responseModel.code == code) {
        _logSuccess(response);
        final model = onModel != null ? onModel(responseModel.data) : responseModel.data as T;
        await onSuccess?.call(responseModel.code, responseModel.msg, model);
        return;
      } else {
        _logError(response);
        await onError?.call(response);
        return;
      }
    } else {
      _logConnectError(response);
      _urlCount++;

      if (_urlCount < urls.length) {
        _index = (_index + 1) % urls.length;
        _httpClient?.baseUrl = urls[_index];
        post<T>(path, data: data, onSuccess: onSuccess, onError: onError, onModel: onModel);
        return;
      }
    }

    await onConnectError?.call(response);
    clearUrlCount();
  }

  Future<void> upload<T>(String path, {
    Future<dynamic> Function(int, String, T)? onSuccess,
    Map<String, dynamic>? data,
    Future<dynamic> Function(Response<dynamic>?)? onError,
    T Function(dynamic)? onModel,
    dynamic Function(double)? uploadProgress,
  }) async {
    final formData = FormData(data ?? {});
    final response = await _httpClient?.post(path,
      body: formData,
      uploadProgress: uploadProgress,
    ).timeout(timeout * 60 * 60 * 24);

    if (response != null && response.isOk ) {
      _urlCount = 0;

      final responseModel = ResponseModel.fromJson( json.decode(response.bodyString ?? '{}'));
      if (responseModel.code == code) {
        _logSuccess(response);
        final model = onModel != null ? onModel(responseModel.data) : responseModel.data as T;
        await onSuccess?.call(responseModel.code, responseModel.msg, model);
        return;
      } else {
        _logError(response);
        await onError?.call(response);
        return;
      }
    } else {
      _logConnectError(response);
      _urlCount++;

      if (_urlCount < urls.length) {
        _index = (_index + 1) % urls.length;
        _httpClient?.baseUrl = urls[_index];
        upload<T>(path, data: data, onSuccess: onSuccess, onError: onError, onModel: onModel);
        return;
      }
    }

    await onConnectError?.call(response);
    clearUrlCount();
  }
}

class ResponseModel {
  int code;
  dynamic data;
  String msg;

  ResponseModel({
    required this.code,
    required this.data,
    required this.msg,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    code: json["code"] ?? -1,
    data: json["data"] ?? {},
    msg: json["msg"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data,
    "msg": msg,
  };
}