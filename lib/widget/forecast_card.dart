import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final Map<String, dynamic>? forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        color: Colors.grey[700],
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${forecast?["date"]}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Image.network('https:${forecast?["day"]["condition"]["icon"]}',
                  height: 40),
              Text('Temp: ${forecast?["day"]["avgtemp_c"]}°C',
                  style: TextStyle(color: Colors.white)),
              Text('Wind: ${forecast?["day"]["maxwind_kph"]} km/h',
                  style: TextStyle(color: Colors.white)),
              Text('Humidity: ${forecast?["day"]["avghumidity"]}%',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
