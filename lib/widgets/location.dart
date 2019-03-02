import 'package:flutter/material.dart';

class Location extends StatelessWidget {

  // Widget para visualização da localização
  final String location;

  const Location({Key key, this.location}) 
  :assert(location != null),
   super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      location, 
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      
    );
  }
}