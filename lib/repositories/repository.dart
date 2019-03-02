

import 'package:weather_app/repositories/api_client.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather_model.dart';

class Repository {
  final ApiClient weatherApi;

  Repository({@required this.weatherApi}):assert (weatherApi !=null);

  Future<Weather> getWeather(String city) async {
    print("obtendo id da cidade");
    final int locationId = await weatherApi.getLocationId(city);
    print("id cidade");
    print(locationId);
    return weatherApi.fetchLocation(locationId);
  }


}