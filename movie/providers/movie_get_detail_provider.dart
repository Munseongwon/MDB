// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:moviedb/movie/models/movie_detail_model.dart';
import 'package:moviedb/movie/repostories/movie_repository.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDetailProvider(this._movieRepository);

  MovieDatailModel? _movie;
  MovieDatailModel? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await _movieRepository.getDetail(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _movie = null;
        notifyListeners();
        return;
      },
      (response) {
        _movie = response;
        notifyListeners();
        return;
      },
    );
  }
}
