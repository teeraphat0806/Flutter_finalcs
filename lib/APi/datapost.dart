import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Character>> fetchData() async {
  final prefs = await SharedPreferences.getInstance();
  final url = Uri.parse('https://rickandmortyapi.com/api/character');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      // 🔐 แคชไว้ใน SharedPreferences
      prefs.setString('cached_characters', json.encode(data));

      return results.map((item) => Character.fromJson(item)).toList();
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  } catch (e) {
    // ❌ ถ้า API ล้มเหลว → ลองโหลดจาก SharedPreferences
    final cached = prefs.getString('cached_characters');
    if (cached != null) {
      final data = json.decode(cached);
      final List<dynamic> results = data['results'];
      return results.map((item) => Character.fromJson(item)).toList();
    } else {
      throw Exception('No internet and no cached data');
    }
  }
}
