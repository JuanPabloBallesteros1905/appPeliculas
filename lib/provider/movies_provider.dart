import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  //mostrar las imagenes de la api en nuestros componentes creados para este proposito

  //1. creamos una lista de tipo Movie (Esta clase se encuentra en nuestro mapeado )
  List<Movie> onDisplayMovies = [];
  //*Lista vacia para las pelicualas populares
  List<Movie> onPopularMovies = [];

  MoviesProvider() {
    print('movies provider inicializado');

    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    //*url de la api
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=7cd9520a02bbf9dedfef489a4e616be3&language=es-ES&page=1');

    //*aqui se hace la peticion http
    final res = await http.get(url);
    //* esta es una variable creada gracias al mapeo que se hizo con ayuda del quicktype en donde se remplaza el jsoncode()
    final nowPlayingResponse = NowPlayingResponse.fromJson(res.body);

    //*aqui se llena con los datos de la api
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=7cd9520a02bbf9dedfef489a4e616be3&language=es-ES&page=1');
    final res = await http.get(url);
    final popularMovies = PopularResponse.fromJson(res.body);
    onPopularMovies = popularMovies.results;

    


    notifyListeners();
  }
}
