import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final String nimPassword = '124240030'; 

  RxString username = ''.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString('username');
    if (savedUser != null && savedUser.isNotEmpty) {
      username.value = savedUser;
      isLoggedIn.value = true;
    }
  }

  Future<String?> login(String user, String password) async {
    if (user.trim().isEmpty) return 'Username tidak boleh kosong';
    if (password != nimPassword) return 'Password harus sesuai NIM';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.trim());
    username.value = user.trim();
    isLoggedIn.value = true;
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    username.value = '';
    isLoggedIn.value = false;
  }
}