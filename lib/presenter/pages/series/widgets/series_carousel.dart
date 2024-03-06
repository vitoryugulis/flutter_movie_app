import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/domain/entities/discover_entity.dart';
import 'package:flutter_movie_app/presenter/utils/styles.dart';

class SeriesCarousel extends StatelessWidget {
  final DiscoverEntity series;
  final String carouselTitle;
  const SeriesCarousel({
    required this.carouselTitle,
    required this.series,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    series.results.shuffle();
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(carouselTitle, style: Styles.mdText),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: series.results.length,
            itemBuilder: (context, index) {
              final movie = series.results[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: movie.fullPath,
                    errorWidget: (context, url, error) => Container(
                      width: 140,
                      color: Colors.indigo,
                      child: Center(child: Text('Sem poster :(', style: Styles.smText,)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
