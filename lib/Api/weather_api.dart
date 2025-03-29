import 'dart:convert';
import 'package:http/http.dart' as http;
class WeatherService {
  static const String apiKey = "c5d0341144d549e79af190452252803";
  static const String baseUrl = 'https://api.weatherapi.com/v1';
  static Future<Map<String, dynamic>?> fetchCurrentWeather(String city) async {
    final url = Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching weather: $e');
    }
    return null;
  }
  static Future<Map<String, dynamic>?> fetchForecastWeather(String city) async {
    final url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$city&days=5&aqi=no&alerts=no');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching forecast: $e');
    }
    return null;
  }

static Future<bool> subscribeEmail(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/subscribe'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> unsubscribeEmail(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/unsubscribe'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    return response.statusCode == 200;
  }
}

