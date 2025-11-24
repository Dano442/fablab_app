import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/domain/models/news_model.dart';

class NewsService {
  final Dio _dio = ApiClient.createDio();

  // =======================
  // OBTENER TODAS LAS NOTICIAS
  // =======================
  Future<List<NewsModel>> getAllNews() async {
    try {
      final response = await _dio.get('/noticias');

      final List data = response.data;
      return data.map((n) => NewsModel.fromJson(n)).toList();
    } catch (e) {
      print("Error al obtener noticias: $e");
      return [];
    }
  }

  // =======================
  // CREAR NOTICIA
  // =======================
  Future<bool> createNews(NewsModel news) async {
    try {
      final payload = news.toJson()..remove("id");

      print("========= PAYLOAD ENVIADO =========");
      print(payload);
      print("===================================");

      final response = await _dio.post(
        '/noticias',
        data: payload,
        options: Options(
          validateStatus: (status) {
            print("STATUS SERVER: $status");
            return true; // Permite ver la respuesta aunque sea error
          },
        ),
      );

      print("===== RESPUESTA DEL SERVIDOR =====");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.data}");
      print("=================================");

      return response.statusCode == 200 || response.statusCode == 201;

    } catch (e) {
      print("EXCEPCIÓN createNews: $e");
      return false;
    }
  }

  // =======================
  // ACTUALIZAR NOTICIA
  // =======================
  Future<bool> updateNews(NewsModel news) async {
    try {
      final payload = news.toJson();

      final response = await _dio.put(
        '/noticias/${news.id}',
        data: payload,
        options: Options(
          validateStatus: (status) {
            print("STATUS SERVER (PUT): $status");
            return true;
          },
        ),
      );

      print("RESPUESTA UPDATE:");
      print(response.data);

      return response.statusCode == 200 || response.statusCode == 204;

    } catch (e) {
      print("ERROR PUT noticia: $e");
      return false;
    }
  }

  // =======================
  // ELIMINAR NOTICIA
  // =======================
  Future<bool> deleteNews(int id) async {
    try {
      final response = await _dio.delete(
        '/noticias/$id',
        options: Options(
          validateStatus: (status) {
            print("STATUS SERVER (DELETE): $status");
            return true;
          },
        ),
      );

      print("RESPUESTA DELETE:");
      print(response.data);

      return response.statusCode == 200 || response.statusCode == 204;

    } catch (e) {
      print("ERROR DELETE noticia: $e");
      return false;
    }
  }
}
