// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:moviedb/movie/models/movie_video_model.dart';
import 'package:moviedb/movie/models/movie_model.dart';
import 'package:moviedb/movie/models/movie_detail_model.dart';
import 'package:moviedb/movie/repostories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio; // json 데이터를 불러오기 위한 http 통신 연결

  MovieRepositoryImpl(this._dio);

  // MovieDetail 모델의 GET Details를 불러오기 위한 과정 --> /movie/{movie_id}
  @override
  Future<Either<String, MovieDatailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDatailModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get movie detail');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get movie detail');
    }
  }

  // MovieResponseModel GET Discover를 불러오기 위한 과정
  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get discover movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get discover movies');
    }
  }

  // MovieResponseModel GET Now Playing 데이터를 불러오고 통신하는 과정
  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get now playing movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
    }
    return const Left('Another error on get now playing movies');
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error get top rated movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
    }
    return const Left('Another error on get top rated movies');
  }

  @override
  Future<Either<String, MovieVideosModel>> getVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id/videos',
      );
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieVideosModel.fromMap(result.data);
        return Right(model);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
    }
    return const Left('Another error on get on movie videos');
  }

  @override
  Future<Either<String, MovieResponseModel>> search(
      {required String query}) async {
    try {
      final result = await _dio.get(
        '/search/movie',
        queryParameters: {"query": query},
      );
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left('Error search movie');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
    }
    return const Left('Another error on search movie');
  }
}
