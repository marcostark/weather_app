import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/settings_bloc.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/repositories/api_client.dart';
import 'package:weather_app/repositories/repository.dart';
import 'package:weather_app/weather.dart';

import 'package:http/http.dart' as http;


class SimpleBlocDelegate extends BlocDelegate {  
  // Ver todas as transições de estado no aplicativo
  @override
  void onTransition(Transition transition) {
    print(transition);
  }  
}

void main(){

  final Repository weatherRepository = Repository (
    weatherApi: ApiClient(
      httpClient: http.Client(),
    ),
  );

  BlocSupervisor().delegate = SimpleBlocDelegate();  
  
  runApp(WeatherApp(weatherRepository: weatherRepository));
}

class WeatherApp extends StatefulWidget  {

  final Repository weatherRepository;

  const WeatherApp({Key key, @required this.weatherRepository})
  :assert(weatherRepository != null),
   super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  ThemeBloc _themeBloc = ThemeBloc();
  SettingsBloc _settingsBloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _themeBloc,
      child: BlocProvider(
        bloc: _settingsBloc,
        child: BlocBuilder(
            bloc: _themeBloc,
            builder: (_, ThemeState themeState){
              return MaterialApp(
                title: 'Clima App',
                theme: themeState.theme,
                home: Weather(
                  weatherRepository: widget.weatherRepository,
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingsBloc.dispose();
    super.dispose();
  }

}