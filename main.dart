// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moviedb/injector.dart';
import 'package:moviedb/movie/pages/movie_page.dart';
import 'package:moviedb/movie/providers/movie_get_discover_provider.dart';
import 'package:moviedb/movie/providers/movie_get_now_playing_provider.dart';
import 'package:moviedb/movie/providers/movie_get_top_rated_provider.dart';
import 'package:moviedb/movie/providers/movie_search_provider.dart';
import 'package:provider/provider.dart';

//Splash Screen When the Application get's started
//Set up app initialization
void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(MovieDBApp());
  FlutterNativeSplash.remove();
}

class MovieDBApp extends StatelessWidget {
  const MovieDBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieSearchProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'MDB',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
