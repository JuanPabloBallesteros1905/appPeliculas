import 'package:flutter/material.dart';
import 'package:peliculas/provider/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //*Aqui empezamos a mostrar el contenido que llega desde la api a nuestra lista
    //*  Debemos definir siempre de que tipo es  para que apunte hacia el y  vaya a buscarlo y no nos de error
    //* en este caso debe apuntar hacia nuestra clase del provider todo esto funciona si en el multiprovider del main, tenemos deifnido el ChangeNotifierProvider
    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_outlined))
          ],
          centerTitle: true,
          title: const Text('Peliculas en cine'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //*aqui le mandamos los parametros al widget

              CardsSwiper(
                  //* aqui le pasamos a la variable movie las peliculas que viene de la lista que creamos en el provider
                  //*  podemos usar el moviesProvider gracia a que se creó el provider allá arriba
                  movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                populares: moviesProvider.onPopularMovies,
                titulo: "Populares!",
                nextPage: () {
                  moviesProvider.getOnPopularmovies();
                },
              ),
            ],
          ),
        ));
  }
}
