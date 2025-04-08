import 'dart:convert';
import 'package:http/http.dart' as http;
import 'marvel_character.dart';

Future<List<MarvelCharacter>> fetchMarvelCharacters() async {
  final response = await http.get(Uri.parse('https://simplifiedcoding.net/demos/marvel/'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => MarvelCharacter.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Marvel characters');
  }
}
