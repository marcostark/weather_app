import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/settings_bloc.dart';
import 'package:weather_app/widgets/conditions.dart';
import 'package:weather_app/widgets/temperatute.dart';

import 'package:meta/meta.dart';

import 'package:weather_app/models/weather_model.dart' as model;

class CombinedWeatherTemperature extends StatelessWidget {
  final model.Weather weather;

  CombinedWeatherTemperature({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ClimaticConditions(condition: weather.condiction),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: BlocBuilder(
                bloc: BlocProvider.of<SettingsBloc>(context),
                builder: (_, SettingsState state){
                  return Temperature(
                  temperature: weather.temp,
                  high: weather.maxTemp,
                  low: weather.minTemp,
                  units: state.temperatureUnits,
                );
                  },
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondiction,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}