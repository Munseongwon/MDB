// ignore_for_file: unused_field, prefer_final_fields, unused_local_variable

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:moviedb/movie/models/movie_model.dart';
import 'package:moviedb/movie/repostories/movie_repository.dart';

class MovieGetNowPlayingProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetNowPlayingProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading; // 영상을 틀기 전에는 isLoading x

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies; // 보여지는 영화 리스트

  void getNowPlaying(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getNowPlaying();

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }

  void getNowPlayingWithPaging(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await _movieRepository.getNowPlaying(page: page);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        pagingController.error = messageError;
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return;
      },
    );
  }
}
