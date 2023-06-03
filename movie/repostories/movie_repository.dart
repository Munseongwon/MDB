// API 데이터 받을 경우
// Failure vs Success --> 두 가지 선택 중 하나만 나오게 해야 함
import 'package:dartz/dartz.dart';
import 'package:moviedb/movie/models/movie_detail_model.dart';
import 'package:moviedb/movie/models/movie_model.dart';
import 'package:moviedb/movie/models/movie_video_model.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1});
  Future<Either<String, MovieResponseModel>> search({required String query});
  Future<Either<String, MovieDatailModel>> getDetail({required int id});
  Future<Either<String, MovieVideosModel>> getVideos({required int id});
}
