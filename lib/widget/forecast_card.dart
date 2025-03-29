import 'package:flutter/material.dart';

class ForecastCard extends StatefulWidget {
  final Map<String, dynamic>? forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}

class _ForecastCardState extends State<ForecastCard> {
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
              Text('${widget.forecast?["date"]}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Image.network('https:${widget.forecast?["day"]["condition"]["icon"]}',
                  height: 40),
              Text('Temp: ${widget.forecast?["day"]["avgtemp_c"]}°C',
                  style: TextStyle(color: Colors.white)),
              Text('Wind: ${widget.forecast?["day"]["maxwind_kph"]} km/h',
                  style: TextStyle(color: Colors.white)),
              Text('Humidity: ${widget.forecast?["day"]["avghumidity"]}%',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
