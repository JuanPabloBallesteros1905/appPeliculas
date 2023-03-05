import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(movie: movie),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterDetails(
            movie: movie,
          ),
          OverView(
            movie: movie,
          ),
          CastingCards()
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          color: Colors.black45,
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          child: Text(movie.title),
          padding: const EdgeInsets.only(bottom: 10),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullbackdroppath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterDetails extends StatelessWidget {
  final Movie movie;

  const _PosterDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 200,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  movie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(movie.voteAverage.toString(),
                        style: textTheme.caption),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '/ 10',
                      style: textTheme.caption,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteCount.toString(),
                      style: textTheme.caption,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'votos',
                      style: textTheme.caption,
                    )
                  ],
                ),
              ],
            )
          ],
        ));
  }
}

class OverView extends StatelessWidget {
  final Movie movie;

  const OverView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
