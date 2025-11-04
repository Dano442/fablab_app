import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/data/storage/secure_storage.dart';
import 'package:fablab_app/domain/models/user_model.dart';

class AuthService {
  final Dio _dio = ApiClient.createDio();

  // Future<bool> login(String email, String password) async {
  //   try {
  //     final response = await _dio.post('/auth/login', data: {
  //       'email': email,
  //       'password': password,
  //     });

  //     final token = response.data['token'];
  //     await SecureStorage.saveToken(token);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<bool> login(String email, String password) async {
  // --- Simulación de autenticación ---
  if (email == 'admin@fablab.cl' && password == '123456') {
    // Guarda un token falso en el almacenamiento
    await SecureStorage.saveToken('fake_jwt_token_123');
    return true;
  } else {
    return false;
  }
}


  Future<void> logout() async {
    await SecureStorage.deleteToken();
  }

  Future<UserModel?> getProfile() async {
    try {
      final response = await _dio.get('/auth/profile');
      return UserModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await SecureStorage.getToken();
    return token != null;
  }
}
