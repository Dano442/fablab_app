import 'package:dio/dio.dart';

class RequestService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fablabwebapi20251104221404-crbeb0b9cafvhqg3.canadacentral-01.azurewebsites.net/api',
    ),
  );
  
  Future<List<dynamic>> getRequests() async {
    final response = await _dio.get('/notificaciones/ingreso');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Error al cargar solicitudes");
    }
  }

  Future<bool> approveRequest(int id) async {
    final response = await _dio.post('/notificaciones/ingreso/$id');
    return response.statusCode == 200;
  }

  Future<bool> rejectRequest(int id) async {
    final response = await _dio.delete('/notificaciones/ingreso/$id');
    return response.statusCode == 200;
  }
}
