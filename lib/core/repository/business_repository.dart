import 'package:dio/dio.dart';
import '../models/business.dart';
import '../services/local_cache.dart';

class BusinessRepository {
  BusinessRepository(this._dio, this._cache);
  final Dio _dio;
  final LocalCache _cache;

  /// Always tries online first; on failure, falls back to local cache.
  Future<List<Business>> fetchBusinesses() async {
    try {
      final res = await _dio.get('https://example.com/businesses.json');
      final data = (res.data as List).cast<dynamic>();
      // persist normalized, not raw
      final normalized = Business.listFromMessyJson(data);
      await _cache.saveBusinessesJson(
        normalized.map((e) => e.toJson()).toList(),
      );
      return normalized;
    } on DioException {
      // fallback to cache
      final cached = await _cache.readBusinessesJson();
      if (cached != null) {
        return cached
            .map(
              (e) => Business.fromMessyJson({
                // Reuse the same normalizer for consistency
                'biz_name': e['name'],
                'bss_location': e['location'],
                'contct_no': e['phone'],
              }),
            )
            .toList();
      }
      rethrow; // surface error when no cache
    }
  }
}
