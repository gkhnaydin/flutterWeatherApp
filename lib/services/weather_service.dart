import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:havadurumuapp/Models/weather.dart';

class WeatherService {
  Future<String> _GetLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error("Konum servisiniz kapalı!");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error("Konum servisiniz kapalı!");
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    final String? city = placemarks[0].administrativeArea;
    if (city == null) {
      Future.error("Konum bilgisi alınamadı!");
    }
    print("---------------------------------------");
    print(city!);
    return city!;
  }

  Future<List<WeatherModel>> GetWeatherData() async {
    var city = await _GetLocation();
    const String token = "2mLdyQEgsbV4oVdw5RJ6Sj:4lkRK7b1Ldtkw9dCLrRiNa";
    final String urlPath =
        "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";
    final Map<String, dynamic> header = {
      "authorization": "apikey " + token,
      "content-type": "application/json",
    };

    var dio = Dio();
    var response = await dio.get(urlPath, options: Options(headers: header));

    if (response.statusCode != 200) {
      return Future.error("Hava durumu API 'ye istek yaparken hata oluştu!");
    }

    final List results = response.data['result'];
    final List<WeatherModel> models =
        results.map((e) => WeatherModel.fromJSON(e)).toList();

    return models;
  }
}
