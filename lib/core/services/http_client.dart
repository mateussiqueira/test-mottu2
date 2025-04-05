
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  final http.Client _client;

  HttpClient(this._client);

  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await _client.get(Uri.parse(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
