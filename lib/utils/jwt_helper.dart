import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtHelper {
  static const _storage = FlutterSecureStorage();

  static Future<String?> getUserEmail() async {
    final token = await _storage.read(key: "token");
    if (token == null) return null;

    final decoded = JwtDecoder.decode(token);

    final email = decoded["email"] ??
        decoded["Email"] ??
        decoded["correo"] ??
        decoded["correoInstitucional"];

    if (email is String && email.isNotEmpty) {
      return email;
    }

    return null;
  }
}
