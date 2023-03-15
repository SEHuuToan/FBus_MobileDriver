import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../data/repository/repository.dart';
import '../../routes/app_pages.dart';
import '../base/base_controller.dart';

class AuthService extends BaseController {
  static final AuthService _instance = AuthService._internal();
  static AuthService get instance => _instance;
  AuthService._internal();

  final Repository _repository = Get.find(tag: (Repository).toString());

  String? _token;

  /// Get token.
  ///
  /// Return null if token expired.
  String? get token {
    if (_token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(_token.toString());

      DateTime? exp =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);

      if (exp.compareTo(DateTime.now()) <= 0) {
        _token = null;
      }
    }
    return _token;
  }

  static Future<bool> login() async {
    bool result = false;

    // TODO: Login

    return result;
  }

  static Future<void> logout() async {
    clearToken();
    Get.toNamed(Routes.LOGIN);
  }

  static void clearToken() {
    instance._token = null;
  }
}
