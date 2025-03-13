import 'dart:convert'; // Thêm để sử dụng json.decode()
import 'package:http/http.dart' as http;
import 'package:movie_app/data/core/api_constants.dart';

class ApiClient {
  final http.Client _client;

  ApiClient(this._client);

  Future<dynamic> get(String path) async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
