import 'package:dio/dio.dart';
import 'package:fablab_app/data/storage/secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl:
            "https://fablabwebapi20251104221404-crbeb0b9cafvhqg3.canadacentral-01.azurewebsites.net/api",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: "application/json",
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.path.contains("login") ||
              options.path.contains("register")) {
            return handler.next(options);
          }

          final token = await SecureStorage.getToken();

          if (token != null) {
            final isExpired = JwtDecoder.isExpired(token);

            if (isExpired) {
              final newToken = await _tryRefreshToken(dio);

              if (newToken == null) {
                await SecureStorage.deleteToken();
                return handler.reject(
                  DioException(
                    requestOptions: options,
                    error: "Token expirado",
                    type: DioExceptionType.badResponse,
                  ),
                );
              }

              await SecureStorage.saveToken(newToken);
              options.headers["Authorization"] = "Bearer $newToken";
            } else {
              // Token válido
              options.headers["Authorization"] = "Bearer $token";
            }
          }

          return handler.next(options);
        },
      ),
    );

    return dio;
  }

  static Future<String?> _tryRefreshToken(Dio dio) async {
    try {
      final response = await dio.post("/auth/refresh");

      if (response.data != null && response.data["token"] != null) {
        return response.data["token"];
      }
    } catch (e) {
      print("Error al refrescar token: $e");
    }
    return null;
  }
}
