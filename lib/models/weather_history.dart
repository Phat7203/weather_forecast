class WeatherHistory {
  final String city;
  final Map<String, dynamic> weatherData;
  final DateTime timestamp;

  WeatherHistory({
    required this.city,
    required this.weatherData,
    required this.timestamp,
  });

  double get temperature => weatherData['current']['temp_c'];
  String get condition => weatherData['current']['condition']['text'];
}