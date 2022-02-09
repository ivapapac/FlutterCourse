import 'package:flutter/material.dart';

class MovieDetailsExtraPosters extends StatelessWidget {
  const MovieDetailsExtraPosters({Key? key, required this.posters})
      : super(key: key);

  final List<String> posters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Text(
            "More movie posters".toUpperCase(),
            style: const TextStyle(fontSize: 14.0, color: Colors.cyan),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: posters.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(posters[index]),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        )
      ],
    );
  }
}