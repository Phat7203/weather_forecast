import 'package:flutter/material.dart';
import 'package:weather_forecast/Api/weather_api.dart';
import 'package:weather_forecast/widget/current_weather_card.dart';
import 'package:weather_forecast/widget/forecast_card.dart';
import '../models/weather_history.dart';

class WeatherDashboard extends StatefulWidget {
  const WeatherDashboard({super.key});

  @override
  State<WeatherDashboard> createState() => _WeatherDashboardState();
}

class _WeatherDashboardState extends State<WeatherDashboard> {
  Map<String, dynamic>? weatherData;
  Map<String, dynamic>? forecastData;
  List<WeatherHistory> weatherHistory = [];

  final TextEditingController _cityController = TextEditingController();

  void fetchWeather(String city) async {
    final currentWeatherData = await WeatherService.fetchCurrentWeather(city);
    final currentForecastData = await WeatherService.fetchForecastWeather(city);
    if (currentWeatherData != null && currentForecastData != null) {
      setState(() {
        weatherData = currentWeatherData;
        forecastData = currentForecastData;
        
        // Add to history
        weatherHistory.add(WeatherHistory(
          city: city,
          weatherData: currentWeatherData,
          timestamp: DateTime.now(),
        ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather("VietNam");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Weather Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter City Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'E.g., New York, London, Tokyo',
                      labelText: 'Enter a City Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_cityController.text.isNotEmpty) {
                          fetchWeather(_cityController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700]),
                      child: Text('Search',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          fetchWeather("VietNam");
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700]),
                      child: Text('Use Current Location',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: CurrentWeatherCard(
                        weatherData: weatherData,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildHistorySection(),
                  SizedBox(height: 10),
                  Text("4-Day Forecast",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final forecast =
                            forecastData?["forecast"]["forecastday"][index + 1];
                        return ForecastCard(forecast: forecast);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Search History",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherHistory.length,
            itemBuilder: (context, index) {
              final history = weatherHistory[index];
              return Card(
                margin: EdgeInsets.only(right: 8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        history.city,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${history.temperature.round()}°C',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${history.timestamp.hour}:${history.timestamp.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
