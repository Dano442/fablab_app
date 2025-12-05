import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/domain/models/user_model.dart';

class UserService {
  final Dio _dio = ApiClient.createDio();

  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _dio.get('/usuarios');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return data.map((e) => UserModel.fromJson(e)).toList();
        }
        return [];
      }

      return [];
    } catch (_) {
      return [];
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final users = await getAllUsers();

      for (final user in users) {
        if (user.correoInstitucional.toLowerCase() == email.toLowerCase()) {
          return user;
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> getUserById(int id) async {
    try {
      final response = await _dio.get('/usuarios/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  Future<bool> addUser(UserModel user) async {
    try {
      await _dio.post('/usuarios', data: user.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      await _dio.put('/usuarios/${user.id}', data: user.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    try {
      await _dio.delete('/usuarios/$id');
      return true;
    } catch (_) {
      return false;
    }
  }
}
