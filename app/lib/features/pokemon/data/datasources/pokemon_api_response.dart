import 'dart:convert';

import 'package:http/http.dart' as http;

class PokemonApiResponse {
  final http.Response response;

  PokemonApiResponse(this.response);

  bool get isSuccess => response.statusCode == 200;
  Map<String, dynamic> get data => json.decode(response.body);
  List<dynamic> get results => data['results'] as List;
}
