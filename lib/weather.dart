import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/widgets/city_selection.dart';
import 'package:weather_app/widgets/combined_weather_temperature.dart';
import 'package:weather_app/widgets/gradient_container.dart';
import 'package:weather_app/widgets/last_update.dart';
import 'package:weather_app/widgets/location.dart';
import 'package:weather_app/repositories/repository.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/widgets/settings.dart';

class Weather extends StatefulWidget {
  final Repository weatherRepository;

  const Weather({Key key, this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;


  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void >();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Settings(),
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                _weatherBloc.dispatch(FetchWeather(city: city));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder(
            bloc: _weatherBloc,
            builder: (_, WeatherState state) {
              if (state is WeatherEmpty) {
                return Center(
                  child: Text('Selecione uma localidade'),
                );
              }
              if (state is WeatherLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherLoaded) {
                final weather = state.weather;
                final themeBloc = BlocProvider.of<ThemeBloc>(context);
                themeBloc.dispatch(WeatherChange(condition: weather.condiction));

                _refreshCompleter?.complete();
                _refreshCompleter = Completer();

                return BlocBuilder(
                  bloc: themeBloc,
                  builder: (_, ThemeState themeState) {
                    return GradientContainer(
                      color: themeState.color,
                      child: RefreshIndicator(
                          onRefresh: () {
                            _weatherBloc.dispatch(
                                RefreshWeather(city: state.weather.location)
                            );
                            return _refreshCompleter.future;
                          },
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 100.0),
                                child: Center(
                                  child: Location(location: weather.location),
                                ),
                              ),
                              Center(
                                child: LastUpdate(
                                    dateTime: weather.lastUpdated),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 50.0),
                                child: Center(
                                  child: CombinedWeatherTemperature(
                                      weather: weather
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    );
                  },
                );                
              }
              if(state is WeatherError){
                return Text(
                  'Algo deu muito errado!',
                  style: TextStyle(color: Colors.red),
                );
              }
            }
          ),
      ),
    );
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }
}
