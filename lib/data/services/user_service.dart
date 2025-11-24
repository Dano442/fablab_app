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
    Future<UserModel?> getUserById(int id) async {
    try {
      final response = await _dio.get('/usuarios/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        print('❌ Error al obtener usuario por ID (${response.statusCode})');
        return null;
      }

    } catch (e) {
      print('❌ Error getUserById: $e');
      return null;
    }
  }


  Future<bool> addUser(UserModel user) async {
    try {
      await _dio.post('/usuarios', data: user.toJson());
      return true;
    } catch (e) {
      print('❌ Error al agregar usuario: $e');
      return false;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      await _dio.put('/usuarios/${user.id}', data: user.toJson());
      return true;
    } catch (e) {
      print('❌ Error al actualizar usuario: $e');
      return false;
    }
  }

Future<bool> deleteUser(int id) async {
  try {
    await _dio.delete('/usuarios/$id');
    return true;
  } catch (e) {
    print('Error al eliminar usuario: $e');
    return false;
  }
}
}
