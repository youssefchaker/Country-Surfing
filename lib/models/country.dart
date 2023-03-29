class Country {
  final String? name;
  final String? flag;
  final String? description;
  final List<String>? images;
  final List<List<String>>? choices;
  final List<int>? answers;
  final List<String>? questions;
  final String? timezone;
  final String? lat;
  final String? lng;
  final String? capital;

  Country({
    required this.name,
    required this.flag,
    required this.description,
    required this.images,
    required this.choices,
    required this.answers,
    required this.questions,
    required this.timezone,
    required this.lat,
      required this.lng,
      required this.capital
  });
}
