import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/data/storage/secure_storage.dart';
import 'package:fablab_app/domain/models/project_model.dart';

class ProjectService {
  final Dio _dio = ApiClient.createDio();

  final String baseUrl = '/proyectos';

  // GET ALL
  Future<List<ProjectModel>> getAllProjects() async {
    try {
      final res = await _dio.get(baseUrl);

      final List data = res.data;
      return data.map((json) => ProjectModel.fromJson(json)).toList();
    } catch (e) {
      print("❌ Error cargando proyectos: $e");
      return [];
    }
  }

  // CREATE (POST)
  Future<bool> createProject(ProjectModel project) async {
    try {
      final token = await SecureStorage.getToken();

      print("=== TOKEN POST ===");
      print(token);

      final body = {
        "titulo": project.titulo,
        "categoria": project.categoria,
        "descripcionProyecto": project.descripcionProyecto,
        "areaAplicacion": project.areaAplicacion,
        "imgUrl": project.imgUrl,
        "fechaInicio": project.fechaInicio.toIso8601String(),
        "usuarios": project.usuarios,
        "hitoProyecto": project.hitoProyecto,
      };

      print("=== JSON ENVIADO AL POST ===");
      print(body);

      final response = await _dio.post(
        baseUrl,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
        data: body,
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("❌ Error en POST");
      print(e);
      return false;
    }
  }

  // UPDATE (PUT)
  Future<bool> updateProject(ProjectModel project) async {
    try {
      final token = await SecureStorage.getToken();

      final body = {
        "id": project.id,
        "titulo": project.titulo,
        "categoria": project.categoria,
        "descripcionProyecto": project.descripcionProyecto,
        "areaAplicacion": project.areaAplicacion,
        "imgUrl": project.imgUrl,
        "fechaInicio": project.fechaInicio.toIso8601String(),
        "usuarios": project.usuarios,
        "hitoProyecto": project.hitoProyecto,
      };

      print("=== JSON ENVIADO AL PUT ===");
      print(body);

      final response = await _dio.put(
        "$baseUrl/${project.id}",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
        data: body,
      );

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error en PUT");
      print(e);
      return false;
    }
  }

  // DELETE
  Future<bool> deleteProject(int id) async {
    try {
      final token = await SecureStorage.getToken();

      final res = await _dio.delete(
        "$baseUrl/$id",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      return res.statusCode == 200;
    } catch (e) {
      print("❌ Error eliminando proyecto: $e");
      return false;
    }
  }
}
