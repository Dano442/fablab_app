import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';

class MetricsService {
  final Dio _dio = ApiClient.createDio();

  Future<Map<String, int>> loadMetrics() async {
    int users = 0;
    int projects = 0;
    int news = 0;
    int requests = 0;

    try {
      final userRes = await _dio.get('/usuarios');
      if (userRes.statusCode == 200 && userRes.data is List) {
        users = (userRes.data as List).length;
      }
    } catch (e) {
      print("⚠ Error obteniendo usuarios: $e");
    }

    try {
      final projectRes = await _dio.get('/proyectos');
      if (projectRes.statusCode == 200 && projectRes.data is List) {
        projects = (projectRes.data as List).length;
      }
    } catch (e) {
      print("⚠ Error obteniendo proyectos: $e");
    }

    try {
      final newsRes = await _dio.get('/noticias');
      if (newsRes.statusCode == 200 && newsRes.data is List) {
        news = (newsRes.data as List).length;
      }
    } catch (e) {
      print("⚠ Error obteniendo noticias: $e");
    }

    try {
      final reqRes = await _dio.get('/solicitudes');
      if (reqRes.statusCode == 200 && reqRes.data is List) {
        requests = (reqRes.data as List).length;
      }
    } catch (e) {
      print("⚠ Error obteniendo solicitudes: $e");
    }

    return {
      "totalProjects": projects,
      "totalUsers": users,
      "totalNews": news,
      "totalRequests": requests,
    };
  }
}
