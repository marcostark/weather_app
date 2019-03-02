import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

import 'package:meta/meta.dart';

class ClimaticConditions extends StatelessWidget {
  final ClimaticCondition condition;

  ClimaticConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);    

  Image _mapConditionToImage(ClimaticCondition condition) {
    Image image;
    switch (condition) {
      case ClimaticCondition.clear:
      case ClimaticCondition.lightCloud:
        image = Image.asset('assets/clear.png');
        break;
      case ClimaticCondition.hail:
      case ClimaticCondition.snow:
      case ClimaticCondition.sleet:
        image = Image.asset('assets/snow.png');
        break;
      case ClimaticCondition.heavyCloud:
        image = Image.asset('assets/cloudy.png');
        break;
      case ClimaticCondition.heavyRain:
      case ClimaticCondition.lightRain:
      case ClimaticCondition.showers:
        image = Image.asset('assets/rainy.png');
        break;
      case ClimaticCondition.thunderstorm:
        image = Image.asset('assets/thunderstorm.png');
        break;
      case ClimaticCondition.unknown:
        image = Image.asset('assets/clear.png');
        break;
    }
    return image;
  }
}