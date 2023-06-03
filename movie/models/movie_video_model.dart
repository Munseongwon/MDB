class Result {
  final String name; // 비디오 이름
  final String key; // 비디오 키
  final String site; // 비디오 사이트
  final String type; // 비디오 타입
  final bool official; // 공식 스릴러 영상 여부
  final String id; // 아이디

  Result(
      {required this.name,
      required this.key,
      required this.site,
      required this.type,
      required this.official,
      required this.id});

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        type: json["type"],
        official: json["official"],
        id: json["id"],
      );
}

class MovieVideosModel {
  final int id;
  final List<Result> results;

  MovieVideosModel({required this.id, required this.results});

  factory MovieVideosModel.fromMap(Map<String, dynamic> json) =>
      MovieVideosModel(
        id: json["id"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );
}
