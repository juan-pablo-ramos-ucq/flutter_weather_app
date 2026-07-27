import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Llaves constantes para evitar errores de dedo (Typos)
  static const String _nameKey = 'name_key';
  static const String _imgURLKey = 'img_url_key';
  static const String _emailKey = 'email_key';

  // Método para guardar los datos
  Future<void> saveUser(
    String name,
    String imgUrl,
    String email,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_imgURLKey, imgUrl);
    await prefs.setString(_emailKey, email);
  }

  Future<void> eraseUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_nameKey);
    await prefs.remove(_imgURLKey);
    await prefs.remove(_emailKey);
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey) ?? '';
  }

  Future<String> getImgUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_imgURLKey) ?? '';
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) ?? '';
  }
}
