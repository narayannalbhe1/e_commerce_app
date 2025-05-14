// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<String>> fetchCategories() async {
    final url = Uri.parse('$baseUrl/products/categories');
    final response = await http.get(url);

    print(response);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<String>();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<dynamic>> fetchProductsByCategory(String category) async {
    final url = Uri.parse('$baseUrl/products/category/$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body); // returns List<Map<String, dynamic>>
    } else {
      throw Exception('Failed to load products for category $category');
    }
  }
}
