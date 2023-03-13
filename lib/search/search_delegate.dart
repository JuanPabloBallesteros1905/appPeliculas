import 'package:flutter/material.dart';
import 'package:peliculas/provider/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscador';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  Widget _empyData() {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.orange,
        size: 150,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _empyData();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _empyData();
        }

        final movies = snapshot.data;

        return ListView.builder(
            itemCount: movies!.length,
            itemBuilder: (_, index) => _MovieList(
                  movie: movies[index],
                ));
      },
    );
  }
}

class _MovieList extends StatelessWidget {
  final Movie movie;

  const _MovieList({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        ListTile(
          leading: GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 100,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(movie.title),
          subtitle: Row(children: [
            const Icon(
              Icons.star_border_outlined,
              size: 15,
              color: Colors.amber,
            ),
            const SizedBox(width: 5),
            Text(movie.voteAverage.toString())
          ]),
          onTap: () {
            Navigator.pushNamed(context, 'details', arguments: movie);
          },
        ),
      ],
    );
  }
}


















    // if (query.isEmpty) {
    //   return const Center(
    //       child: Icon(
    //     Icons.movie_creation_outlined,
    //     size: 150,
    //     color: Colors.grey,
    //   ));
    // } else {
    //   return Container();
    // }
