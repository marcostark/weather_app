import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather_model.dart';

class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  ThemeState({@required this.theme, @required this.color})
      : assert(theme != null),
        assert(color != null),
        super([theme, color]);
}

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super(props);
}

class WeatherChange extends ThemeEvent {
  /*
  * Consiste de um único evento, que será despachado
  * sempre que as condições climáticas que está sendo exibida
  * tiver mudado.
  * */
  final ClimaticCondition condition;

  WeatherChange({@required this.condition})
  :assert(condition != null),
  super([condition]);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{

  @override
  ThemeState get initialState => ThemeState(
    theme: ThemeData.light(),
    color: Colors.lightBlue,
  );

  @override
  Stream<ThemeState> mapEventToState(
      ThemeState currentState,
      ThemeEvent event) async* {
    if(event is WeatherChange) {
      yield _mapWeatherConditionToThemeData(event.condition);
    }
  }

  ThemeState _mapWeatherConditionToThemeData(ClimaticCondition condition) {
    // Converter a condição climatica em um novo tema (ThemeState)
    ThemeState theme;
    switch(condition){
      case ClimaticCondition.clear:
      case ClimaticCondition.lightCloud:
      theme = ThemeState(
        theme: ThemeData(
          primaryColor: Colors.orangeAccent
        ),
        color: Colors.yellow
      );
      break;
      case ClimaticCondition.hail:
      case ClimaticCondition.snow:
      case ClimaticCondition.sleet:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.lightBlueAccent,
          ),
          color: Colors.lightBlue,
        );
        break;
      case ClimaticCondition.heavyCloud:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.blueGrey,
          ),
          color: Colors.grey,
        );
        break;
      case ClimaticCondition.heavyRain:
      case ClimaticCondition.lightRain:
      case ClimaticCondition.showers:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.indigoAccent,
          ),
          color: Colors.indigo,
        );
        break;
      case ClimaticCondition.thunderstorm:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.deepPurpleAccent,
          ),
          color: Colors.deepPurple,
        );
        break;
      case ClimaticCondition.unknown:
        theme = ThemeState(
          theme: ThemeData.light(),
          color: Colors.lightBlue,
        );
        break;
    }
    return theme;
  }
}
