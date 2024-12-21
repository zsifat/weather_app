import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '1de903cf1bff457ba5474130241012';
  final String baseUrl = 'http://api.weatherapi.com/v1';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      String url =
          '$baseUrl/forecast.json?key=$apiKey&q=$city&days=7&aqi=no&alerts=no';
      print('Fetching URL: $url');

      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timed out');
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error response: ${response.body}');
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error details: $e');
      if (e.toString().contains('SocketException')) {
        throw Exception('Network error: Please check your internet connection');
      }
      throw Exception('Failed to fetch weather data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getSearchSugestions(String city) async {
    try {
      final sugestionResponse = await http.get(Uri.parse(
          'https://api.weatherapi.com/v1/search.json?key=$apiKey&q=$city'));
      if (sugestionResponse.statusCode == 200) {
        return List<Map<String, dynamic>>.from(
            jsonDecode(sugestionResponse.body));
      } else {
        print('Error: ${sugestionResponse.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting suggestions: $e');
      return [];
    }
  }
}
