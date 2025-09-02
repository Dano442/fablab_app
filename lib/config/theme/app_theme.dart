import 'package:flutter/material.dart';

// Colores de los temas
const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  
  final int selectedColor;

  AppTheme({
    this.selectedColor = 0 
    }): assert (selectedColor >= 0, 'El color seleccionado debe ser mayor que 0'),
        assert(selectedColor <colorList.length,
        'El color seleccionado debe ser menor que ${colorList.length - 1} ');


    ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorList[selectedColor],
      appBarTheme: const AppBarTheme(
        centerTitle: false
      )
    );


}