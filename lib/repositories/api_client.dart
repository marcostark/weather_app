import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class ApiClient {

  static const url = 'https://www.metaweather.com';
  final http.Client httpClient;

  ApiClient({this.httpClient}):assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final cityIdUrl = '$url/api/location/search/?query=$city';
    final locationResponse =await this.httpClient.get(cityIdUrl);
    print(locationResponse.body);
    if(locationResponse.statusCode != 200 ){
      throw Exception('Erro ao obter localidade');
    }
    final locationJson = jsonDecode(locationResponse.body) as List;
    print(locationJson.first['woeid']);
    return (locationJson.first['woeid']);
  }

  Future<Weather> fetchLocation(int locationId) async {
    final cityUrl = '$url/api/location/$locationId';
    print(cityUrl);
    final cityResponse =await this.httpClient.get(cityUrl);

    if(cityResponse.statusCode != 200 ){
      throw Exception('Erro ao obter localidade');
    }

    final cityJson =jsonDecode(cityResponse.body);
    return Weather.fromJson(cityJson);
  }





}