import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_app/board_firestore/board_app.dart';
import 'package:first_flutter_app/flutter_maps/quakes_map_app/quakes_app.dart';
import 'package:first_flutter_app/flutter_maps/simple_google_map/show_map.dart';
import 'package:first_flutter_app/parsing_json/json_parsing.dart';
import 'package:first_flutter_app/ui/QuizApp.dart';
import 'package:first_flutter_app/ui/movie_ui/MovieListView.dart';
import 'package:first_flutter_app/weather_forecast/weather_forecast.dart';
import 'package:flutter/material.dart';

final ThemeData _appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.red,
      backgroundColor: Colors.amber,
      textTheme: _appTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(centerTitle: true, color: Colors.green));
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith(
      headline1: base.headline1?.copyWith(fontWeight: FontWeight.w500, fontSize: 18.0),
      caption: base.caption?.copyWith(fontWeight: FontWeight.w400, fontSize: 14.0),
      bodyText2:
          base.bodyText2?.copyWith(fontSize: 16.9, color: Colors.white, fontFamily: "Festive"),
      button: base.button?.copyWith(letterSpacing: 3.0, backgroundColor: Colors.red));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: BoardApp()));
}
