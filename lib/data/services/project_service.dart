import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/data/storage/secure_storage.dart';
import 'package:fablab_app/domain/models/project_model.dart';

class ProjectService {
  final Dio _dio = ApiClient.createDio();
  final String baseUrl = '/proyectos';

  Future<List<ProjectModel>> getAllProjects() async {
    try {
      final res = await _dio.get(baseUrl);
      final List data = res.data;
      return data.map((json) => ProjectModel.fromJson(json)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> createProject(ProjectModel project, {MultipartFile? image}) async {
    try {
      final token = await SecureStorage.getToken();

      const int userId = 7;

      final Map<String, dynamic> jsonMap = {
        "Titulo": project.titulo,
        "Categoria": project.categoria ?? "",
        "DescripcionProyecto": project.descripcionProyecto ?? "",
        "AreaAplicacion": project.areaAplicacion ?? "",
        "FechaInicio": (project.fechaInicio ?? DateTime.now()).toIso8601String(),
        "Ids": [userId],
        "ImgUrl": null,
      };

      final formData = FormData.fromMap({
        "DataProject": jsonEncode(jsonMap),
        "ImgUrl": image
      });

      final res = await _dio.post(
        baseUrl,
        data: formData,
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      return res.statusCode == 200 || res.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateProject(ProjectModel project) async {
    try {
      final token = await SecureStorage.getToken();

      final body = {
        "titulo": project.titulo,
        "categoria": project.categoria,
        "descripcionProyecto": project.descripcionProyecto,
        "areaAplicacion": project.areaAplicacion,
        "fechaInicio": (project.fechaInicio ?? DateTime.now()).toIso8601String(),
      };

      final res = await _dio.put(
        "$baseUrl/${project.id}",
        data: body,
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      return res.statusCode == 204 || res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteProject(int id) async {
    try {
      final token = await SecureStorage.getToken();

      final res = await _dio.delete(
        "$baseUrl/$id",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
