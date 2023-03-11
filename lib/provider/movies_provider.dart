import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  //*aqui creo unos parametros para el url
  final String _apiKey = '7cd9520a02bbf9dedfef489a4e616be3';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-ES';

  //*Aqui creamos una lista vacia la cual se llenara con los datos provenientes del
  List<Movie> onDisplayMovies = [];

  List<Movie> onPopularMovies = [];

  List<Movie> onTreadingMovies = [];

  //*actores

  Map<int, List<Cast>> movieCast = {};

  //*propiedad de aunmento de las paginas

  int pages = 0;

  MoviesProvider() {
    print('movies provider inicializado');

    getOnDisplayMovies();
    getOnPopularmovies();
    getTreadingMovies();
  }

  //* metodo creado para optimizar el codigo

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endPoint,
        {'api_key': _apiKey, 'language': _lenguage, 'page': '$page'});

    var response = await http.get(url);
    return response.body;
  }

  //* Metodo que se ejecuta al iniciar la app gracias al provider
  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    //*aqui llenamos esa lista vacia con los datos provenientes de la api
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getOnPopularmovies() async {
    pages++;

    final jsonData = await _getJsonData('3/movie/popular', pages);

    final popular = PopularResponse.fromJson(jsonData);
    onPopularMovies = popular.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    print('pidiendo info Cast');
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CredistResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  getTreadingMovies() async {
    final jsonData = await _getJsonData('3/trending/movie/week');
    final treading = TreandingRespomse.fromJson(jsonData);

    onTreadingMovies = treading.results;

    notifyListeners();
  }
}
