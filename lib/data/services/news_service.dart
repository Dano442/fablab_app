import 'package:dio/dio.dart';
import 'package:fablab_app/data/services/api_client.dart';
import 'package:fablab_app/domain/models/news_model.dart';

class NewsService {
  final Dio _dio = ApiClient.createDio();

  Future<List<NewsModel>> getAllNews() async {
    try {
      final response = await _dio.get('/noticias');

      final List data = response.data;
      return data.map((n) => NewsModel.fromJson(n)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> createNews(NewsModel news) async {
    try {
      final payload = news.toJson()..remove("id");

      final response = await _dio.post(
        '/noticias',
        data: payload,
        options: Options(
          validateStatus: (status) {
            return true; 
          },
        ),
      );

      return response.statusCode == 200 || response.statusCode == 201;

    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNews(NewsModel news) async {
    try {
      final payload = news.toJson();

      final response = await _dio.put(
        '/noticias/${news.id}',
        data: payload,
        options: Options(
          validateStatus: (status) {
            return true;
          },
        ),
      );

      return response.statusCode == 200 || response.statusCode == 204;

    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNews(int id) async {
    try {
      final response = await _dio.delete(
        '/noticias/$id',
        options: Options(
          validateStatus: (status) {
            return true;
          },
        ),
      );

      return response.statusCode == 200 || response.statusCode == 204;

    } catch (e) {
      return false;
    }
  }
}
