import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:havadurumuapp/Models/weather.dart';
import 'package:havadurumuapp/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeatherModel> weatherModels = [];
  void getWeatherData() async {
    weatherModels = await WeatherService().GetWeatherData();
    setState(() {});
  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: weatherModels.length,
          itemBuilder: (context, index) {
            var model = weatherModels[index];
            return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.network(
                    model.ikon,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 25),
                    child: Text(
                      "${model.gun}\n${model.havaDurum.toUpperCase()} ${model.derece}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Min: ${model.min}",
                          ),
                          Text(
                            "Max: ${model.max}",
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gece: ${model.gece}",
                          ),
                          Text(
                            "Nem: ${model.nem}",
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
