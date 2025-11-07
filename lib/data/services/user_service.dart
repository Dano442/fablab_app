import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/domain/models/user_model.dart';

class UserService {
  final Dio _dio = ApiClient.createDio();

  // 🔹 Obtener todos los usuarios desde el endpoint de Azure
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _dio.get('/usuarios');
      if (response.statusCode == 200) {
        final data = response.data;

        // Si la API devuelve una lista de usuarios
        if (data is List) {
          return data.map((e) => UserModel.fromJson(e)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Error al obtener usuarios (${response.statusCode})');
      }
    } catch (e) {
      print('❌ Error al obtener usuarios: $e');
      return [];
    }
  }

  // 🔹 Agregar un usuario nuevo
  Future<bool> addUser(UserModel user) async {
    try {
      await _dio.post('/usuarios', data: user.toJson());
      return true;
    } catch (e) {
      print('❌ Error al agregar usuario: $e');
      return false;
    }
  }

  // 🔹 Actualizar usuario existente
  Future<bool> updateUser(UserModel user) async {
    try {
      await _dio.put('/usuarios/${user.id}', data: user.toJson());
      return true;
    } catch (e) {
      print('❌ Error al actualizar usuario: $e');
      return false;
    }
  }

  // 🔹 Eliminar usuario
  Future<bool> deleteUser(String id) async {
    try {
      await _dio.delete('/usuarios/$id');
      return true;
    } catch (e) {
      print('❌ Error al eliminar usuario: $e');
      return false;
    }
  }
}
