/* Genre
  - tmdb api의  json list data /discover/movie/ 의 요소 중 genre 리스트를 클래스로 바꾼 것
*/
/* MovieResponseModel
  - 영화 리스트 하나를 선택하였을 때, 해당 상세보기 페이지에서 보여질 수 있는 요소들을 배치한 모델
*/
// Factory 키워드를 사용하여 싱글톤 패턴 디자인으로 설계함
class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromMap(Map<String, dynamic> json) =>
      Genre(id: json["id"], name: json["name"]);

  @override
  String toString() => 'Genre(id: $id, name: $name)';
}

class MovieDatailModel {
  final bool adult; // 성인 관람용 여부
  final String backdropPath; // 영화 화면 전환
  final int budget; // 영화 예산
  final List<Genre> genres; // 영화 장르 종류
  final String homepage; // 영화 공식 홈페이지
  final int id; // 영화 각 고유 Id
  final String overview; // 영화 감상평
  final double popularity; // 영화 인기도
  final String posterPath; // 영화 포스터 url
  final DateTime releaseDate; // 영화 개봉일
  final int revenue; // 영화 수익
  final String status; // 영화 상태
  final String tagline; // 영화 태그라인
  final String title; // 영화 제목
  final double voteAverage; // 영화 평점
  final int voteCount; // 영화 투표 수

  MovieDatailModel(
      {required this.adult,
      this.backdropPath = '',
      required this.budget,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.overview,
      required this.popularity,
      this.posterPath = '',
      required this.releaseDate,
      required this.revenue,
      required this.status,
      required this.tagline,
      required this.title,
      required this.voteAverage,
      required this.voteCount});

  factory MovieDatailModel.fromMap(Map<String, dynamic> json) =>
      MovieDatailModel(
          adult: json["adult"],
          backdropPath: json["backdrop_path"],
          budget: json["budget"],
          genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
          homepage: json["homepage"],
          id: json["id"],
          overview: json["overview"],
          popularity: json["popularity"].toDouble(),
          posterPath: json["poster_path"],
          releaseDate: DateTime.parse(json["release_date"]),
          revenue: json["revenue"],
          status: json["status"],
          tagline: json["tagline"],
          title: json["title"],
          voteAverage: json["vote_average"],
          voteCount: json["vote_count"]);

  @override
  String toString() {
    return 'MovieDetailModel(adult: $adult, backdropPath: $backdropPath, budget: $budget, genres: $genres, homepage: $homepage, id: $id, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, revenue: $revenue, status: $status, tagline: $tagline, title: $title, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}
