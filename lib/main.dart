import 'package:flutter/material.dart';
import 'package:peliculas/provider/movies_provider.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:provider/provider.dart';

//esta linea de codigo ejecuta el widget >AppState
void main() => runApp(AppState());

//Este es el AppState, el cual se ejecuta de primero, sin embargo, al no tener widgets que renderisar (ya que es un provider)
//Debemos especificar un child con la app en si que en este caso es MyApp

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

//MyApp es el main de toda la app por eso debe ser usada en el child del provider

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      //indica la ruta inicial
      initialRoute: 'home',
      //se crean las rutas de la app las cuales van en un mapa
      routes: {'home': (_) => HomeScreen(), 'details': (_) => Details()},
      //este es el tema de nuestra app
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(color: Color.fromRGBO(110, 4, 4, 70))),
    );
  }
}
