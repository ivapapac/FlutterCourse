import 'package:first_flutter_app/model/Movie.dart';
import 'package:flutter/material.dart';

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} • ${movie.genre}".toUpperCase(),
          style:
              const TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          movie.title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
        Text.rich(TextSpan(
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            children: <TextSpan>[
              TextSpan(text: movie.plot),
              const TextSpan(
                  text: " More...", style: TextStyle(color: Colors.cyan))
            ]))
      ],
    );
  }
}
