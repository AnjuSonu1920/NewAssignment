class Excercise {
  final String name;
  final String id;
  final String bodyPart;
  final String target;
  final String equipment;
  final String gifUrl;

  const Excercise({
    required this.name,
    required this.id,
    required this.bodyPart,
    required this.target,
    required this.equipment,
    required this.gifUrl,
  });

  static Excercise fromJson(json) => (
    Excercise(
      name: json['name'],
      id: json['id'],
      bodyPart: json['bodyPart'],
      target: json['target'],
      equipment: json['equipment'],
      gifUrl: json['gifUrl'],
  ));
}


class ExcerciseDetail {
  final String name;
  final String id;
  final String bodyPart;
  final String target;
  final String equipment;
  final String gifUrl;

  const ExcerciseDetail({
    required this.name,
    required this.id,
    required this.bodyPart,
    required this.target,
    required this.equipment,
    required this.gifUrl,
  });

  factory ExcerciseDetail.fromJson(Map<String, dynamic> json) {
    return ExcerciseDetail(
      name: json['name'],
      id: json['id'],
      bodyPart: json['bodyPart'],
      target: json['target'],
      equipment: json['equipment'],
      gifUrl: json['gifUrl'],
    );
  }
}