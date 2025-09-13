import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Intercepts requests to `/businesses.json` and serves asset data via Dio.
class LocalAssetMockInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.endsWith('/businesses.json')) {
      
      // Simulate network latency and catch potential errors via this try/catch
      try {
        final text = await rootBundle.loadString('assets/data/businesses.json');
        final data = jsonDecode(text);
        handler.resolve(
          Response(requestOptions: options, statusCode: 200, data: data),
        );
        return;
      } catch (e) {
        handler.reject(DioException(requestOptions: options, error: e));
        return;
      }
    }
    super.onRequest(options, handler);
  }
}
