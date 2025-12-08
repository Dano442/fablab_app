import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';

class IngresoService {
  final Dio _dio = ApiClient.createDio();

  Future<List<dynamic>> getIngresos() async {
    try {
      final res = await _dio.get('/notificaciones/ingreso');

      if (res.statusCode == 200 && res.data is List) {
        return res.data as List;
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
