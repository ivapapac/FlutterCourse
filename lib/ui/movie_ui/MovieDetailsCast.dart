import 'package:first_flutter_app/model/Movie.dart';
import 'package:first_flutter_app/ui/movie_ui/MovieField.dart';
import 'package:flutter/material.dart';

class MovieDetailsCast extends StatelessWidget {
  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        children: <Widget>[
          MovieField(field: "Awards", value: movie.awards),
          MovieField(field: "Language", value: movie.language),
          MovieField(field: "Country", value: movie.country),
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Writers", value: movie.writer)
        ],
      ),
    );
  }
}