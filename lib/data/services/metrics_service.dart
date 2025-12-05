import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';

class MetricsService {
  final Dio _dio = ApiClient.createDio();

  Future<Map<String, int>> loadMetrics() async {
    return {
      "totalProjects": await _countItems('/proyectos'),
      "totalUsers": await _countItems('/usuarios'),
      "totalNews": await _countItems('/noticias'),
      "totalRequests": await _countItems('/solicitudes'),
    };
  }

  Future<int> _countItems(String endpoint) async {
    try {
      final res = await _dio.get(endpoint);
      if (res.statusCode == 200 && res.data is List) {
        return (res.data as List).length;
      }
    } catch (_) {
    }
    return 0;
  }
}
