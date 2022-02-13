import 'package:first_flutter_app/model/Movie.dart';
import 'package:first_flutter_app/ui/movie_ui/HorizontalLine.dart';
import 'package:first_flutter_app/ui/movie_ui/MovieDetailsCast.dart';
import 'package:first_flutter_app/ui/movie_ui/MovieDetailsExtraPosters.dart';
import 'package:first_flutter_app/ui/movie_ui/MovieDetailsHeaderWithPoster.dart';
import 'package:first_flutter_app/ui/movie_ui/MovieDetailsThumbnail.dart';
import 'package:flutter/material.dart';

class MovieListViewDetails extends StatelessWidget {
  const MovieListViewDetails({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        body: ListView(
          children: <Widget>[
            MovieDetailsThumbnail(thumbnail: movie.images[0]),
            MovieDetailsHeaderWithPoster(movie: movie),
            const HorizontalLine(),
            MovieDetailsCast(movie: movie),
            const HorizontalLine(),
            MovieDetailsExtraPosters(posters: movie.images)
          ],
        ));
  }
}
