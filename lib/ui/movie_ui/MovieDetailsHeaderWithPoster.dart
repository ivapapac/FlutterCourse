import 'package:first_flutter_app/model/Movie.dart';
import 'package:first_flutter_app/ui/movie_ui/MovieDetailsHeader.dart';
import 'package:first_flutter_app/ui/movie_ui/MoviePoster.dart';
import 'package:flutter/material.dart';

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  const MovieDetailsHeaderWithPoster({Key? key, required this.movie})
      : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          MoviePoster(poster: movie.images[0]),
          const SizedBox(width: 16),
          Expanded(child: MovieDetailsHeader(movie: movie))
        ],
      ),
    );
  }
}