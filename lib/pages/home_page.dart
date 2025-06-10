import 'package:app03_peliculas/providers/movies_providers.dart';
import 'package:app03_peliculas/widgets/card_swiper.dart';
import 'package:app03_peliculas/widgets/movie_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Renepelis'),
        elevation: 5,
      ),
      body: Column(
        children: [
          CardSwiper(movies: moviesProvider.onDisplayMovies),
          MovieSlider(
            movies: moviesProvider.popularMovies,
            title: 'Populares'
          ),
        ],
      ),
    );
  }
}