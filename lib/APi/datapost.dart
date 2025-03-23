import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/character_model.dart';

Future<List<Character>> fetchData() async {
  final url = Uri.parse('https://rickandmortyapi.com/api/character');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> results = data['results'];

    return results.map((item) => Character.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load characters');
  }
}
