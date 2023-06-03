// ignore_for_file: unused_field, prefer_final_fields, unused_local_variable

import 'package:flutter/material.dart';
import 'package:moviedb/movie/models/movie_model.dart';
import 'package:moviedb/movie/repostories/movie_repository.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieSearchProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading; // progress indicator

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies =>
      _movies; // when user types a movie in the search textfield and enters, the movie's list screen shows at the app

  // Search Provider
  // 쿼리를 가져옴 --> 해당 영화 리스트
  // 영화 제목을 입력하지 않을 시 snackbar 로 영화를 검색하시오.
  // 영화 제목을 입력할 시 해당 영화 리스트 목록을 가져옴
  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.search(query: query);
    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _movies.clear();
      _movies.addAll(response.results);
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
