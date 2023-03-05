import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peliculas/provider/movies_provider.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> populares;
  final String? titulo;

  final Function nextPage;

  const MovieSlider({
    this.titulo,
    required this.populares,
    required this.nextPage,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        timer();
      }
    });
  }

  //*Funcion para que no esté llamando muchas veces
  Future timer() async {
    await Future.delayed(const Duration(seconds: 1));
    widget.nextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);


    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.titulo!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                itemCount: widget.populares.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) => _MoviePoster(
                      movie: widget.populares[index],
                    )),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 185,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            movie.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
