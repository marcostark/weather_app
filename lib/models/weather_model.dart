import 'package:equatable/equatable.dart';

enum ClimaticCondition {
  snow,
  sleet, 
  hail, 
  thunderstorm,
  lightRain,
  heavyRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {

  final ClimaticCondition condiction;
  final String formattedCondiction;
  final double minTemp;
  final double maxTemp;
  final int locationId;
  final double temp;
  final String created;
  final DateTime lastUpdated;
  final String location;

  Weather({
    this.condiction, 
    this.formattedCondiction,
    this.minTemp,
    this.maxTemp,
    this.locationId,
    this.temp,
    this.created, 
    this.lastUpdated, 
    this.location}) :super([
      condiction,
      formattedCondiction,
      minTemp,
      maxTemp,
      locationId,
      temp,
      created,
      lastUpdated,
      location
    ]);

    static Weather fromJson(dynamic json) {
      final consolidatedWeather = json['consolidated_weather'][0];
      return Weather (
        condiction: __mapStringToClimaticCondition(
          consolidatedWeather['weather_state_abbr']
        ),
        formattedCondiction: consolidatedWeather['weather_state_name'],
        minTemp: consolidatedWeather['min_temp'] as double,
        temp:consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId: json['woeid'] as int,
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: json['title'],
        );
    }

    static ClimaticCondition __mapStringToClimaticCondition(String input){
      ClimaticCondition state;
      switch (input) {
        case 'sn':
          state = ClimaticCondition.snow;
          break;
        case 'sl':
          state = ClimaticCondition.sleet;
          break;
        case 'h':
          state = ClimaticCondition.hail;
          break;
        case 't':
          state = ClimaticCondition.thunderstorm;
          break;
        case 'hr':
          state = ClimaticCondition.heavyRain;
          break;
        case 'lr':
          state = ClimaticCondition.lightRain;
          break;
        case 's':
          state = ClimaticCondition.showers;
          break;
        case 'hc':
          state = ClimaticCondition.heavyCloud;
          break;
        case 'lc':
          state = ClimaticCondition.lightCloud;
          break;
        case 'c':
          state = ClimaticCondition.clear;
          break;
        default:
          state = ClimaticCondition.unknown;
      }
      return state;
    }

  
  
}