import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';

class MetricsService {
  final Dio _dio = ApiClient.createDio();

  Future<Map<String, int>> loadMetrics() async {
    return {
      "totalProjects": await _countItems('/proyectos'),
      "totalUsers": await _countItems('/usuarios'),
      "totalNews": await _countItems('/noticias'),
      "totalRequests": await _countItems('/notificaciones/ingreso'),
    };
  }

  Future<int> _countItems(String endpoint) async {
    try {
      final res = await _dio.get(endpoint);
      final data = res.data;

      if (data is List) {
        return data.length;
      }

      if (data is Map) {
        if (data.isEmpty) return 0;
        return 1;
      }

    } catch (_) {
    }

    return 0;
  }
}
