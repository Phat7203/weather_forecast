import 'package:flutter/material.dart';

class CurrentWeatherCard extends StatelessWidget {
  final Map<String, dynamic>? weatherData;

  const CurrentWeatherCard({super.key, required this.weatherData});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[400],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${weatherData?["location"]["name"]} (${weatherData?["location"]["localtime"]})',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text('Temp: ${weatherData?["current"]["temp_c"]}°C',
                    style: TextStyle(color: Colors.white)),
                Text('Wind: ${weatherData?["current"]["wind_kph"]} km/h',
                    style: TextStyle(color: Colors.white)),
                Text('Humidity: ${weatherData?["current"]["humidity"]}%',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Image.network(
                  'https:${weatherData?["current"]["condition"]["icon"]}',
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                Text(
                  '${weatherData?["current"]["condition"]["text"]}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
