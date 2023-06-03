// ignore_for_file: non_constant_identifier_names
/* MovieModel
  - tmdb api의  json list data /discover/movie/ 를 영화 한 편 그 자체의 모델로 만든 것
*/
/* MovieResponseModel
  - tmdb로부터 받은 영화 리스트 목록을 앱 화면에서 보일 수 있도록 하는 모델
*/

class MovieModel {
  final String? backdropPath; // 새로운 화면
  final int id; // 영화 고유 id 번호
  final String overview; // 영화 리뷰
  final String? posterPath; // 영화 포스터 경로 --> url
  final String title; // 영화 제목
  final double voteAverage; // 영화 평균 평점
  final int voteCount; // 영화 평점(고객이 부여)

  MovieModel(
      {this.backdropPath,
      required this.id,
      required this.overview,
      this.posterPath,
      required this.title,
      required this.voteAverage,
      required this.voteCount});

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        backdropPath: json["backdrop_path"] ?? '',
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? '',
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}

class MovieResponseModel {
  final int page; // 영화 리스트 한 페이지 수
  final List<MovieModel> results; // 영화 리스트 목록
  final int totalPages; // 영화 리스트 총 페이지 수
  final int totalResults; // 총 영화 리스트 결과값

  MovieResponseModel(
      {required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults});

  factory MovieResponseModel.fromMap(Map<String, dynamic> json) =>
      MovieResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
