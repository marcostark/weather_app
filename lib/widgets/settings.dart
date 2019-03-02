import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/blocs/settings_bloc.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: ListView(
        children: <Widget>[
          BlocBuilder(
              bloc: settingsBloc,
              builder: (_, SettingsState state) {
                return ListTile(
                  title: Text(
                    'Temperature Units',
                  ),
                  isThreeLine: true,
                  subtitle:
                  Text('Use metric measurements for temperature units.'),
                  trailing: Switch(
                    value: state.temperatureUnits == TemperatureUnits.celsius,
                    onChanged: (_) =>
                        settingsBloc.dispatch(TemperatureUnitsToggled()),
                  ),
                );
              }),
        ],
      ),
    );
  }
}