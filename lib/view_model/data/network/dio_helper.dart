import 'package:dio/dio.dart';
import '../local/shared_helper.dart';
import '../local/shared_keys.dart';
import 'endpoints.dart';

class DioHelper {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: EndPoints.baseUrl,
    receiveDataWhenStatusError: true,
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
  ));

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? withToken = false,
  }) async {
    try {
      if (withToken!) {
        _dio.options.headers.addAll({
          'Authorization': 'Bearer ${SharedHelper.getData(SharedKeys.token)}',
        });
      }
      Response response =
      await _dio.get(path, data: body, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> post({
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool? withToken = false,

  }) async {
    try {
      if (withToken!) {
        _dio.options.headers.addAll({
          'Authorization': 'Bearer ${SharedHelper.getData(SharedKeys.token)}',
        });
      }
      Response response =
      await _dio.post(path, data: body, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> put({
    required String path,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    bool? withToken = false,
  }) async {
    try {
      if (withToken!) {
        _dio.options.headers.addAll({
          'Authorization': 'Bearer ${SharedHelper.getData(SharedKeys.token)}',
        });
      }
      Response response =
      await _dio.put(path, data: body, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> patch({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? withToken = false,
  }) async {
    try {
      if (withToken!) {
        _dio.options.headers.addAll({
          'Authorization': 'Bearer ${SharedHelper.getData(SharedKeys.token)}',
        });
      }
      Response response =
      await _dio.patch(path, data: body, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool? withToken = false,
  }) async {
    try {
      if (withToken!) {
        _dio.options.headers.addAll({
          'Authorization': 'Bearer ${SharedHelper.getData(SharedKeys.token)}',
        });
      }
      Response response =
      await _dio.delete(path, data: body, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}