import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/data/storage/secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final Dio _dio = ApiClient.createDio();

  
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/autenticacion/usuarios/login',
        data: {
          "Email": email,
          "Contrasena": password,
        },
      );

      if (response.data != null && response.data["token"] != null) {
        final token = response.data["token"];
        await SecureStorage.saveToken(token);
        return true;
      }

      return false;
    } catch (e) {
      print("Error en login: $e");
      return false;
    }
  }

  Future<void> logout() async {
    await SecureStorage.deleteToken();
  }

  Future<bool> checkStatus() async {
    try {
      final response =
          await _dio.get('/autenticacion/usuarios/check-status');

      return response.statusCode == 200;
    } catch (e) {
      print("Error en check-status: $e");
      return false;
    }
  }

  /// VALIDACIÓN REAL DE SESIÓN
  Future<bool> isLoggedIn() async {
    final token = await SecureStorage.getToken();
    if (token == null) return false;

    final isExpired = JwtDecoder.isExpired(token);
    if (isExpired) return false;

    return await checkStatus();
  }
}
