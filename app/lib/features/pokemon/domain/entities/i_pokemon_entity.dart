/// Interface for Pokemon entity
abstract class IPokemonEntity {
  /// The unique identifier of the Pokemon
  int get id;

  /// The name of the Pokemon
  String get name;

  /// The URL of the Pokemon's official artwork
  String get imageUrl;

  /// The types of the Pokemon (e.g., ["fire", "flying"])
  List<String> get types;

  /// The base experience points of the Pokemon
  int get baseExperience;

  /// The height of the Pokemon in decimeters
  int get height;

  /// The weight of the Pokemon in hectograms
  int get weight;

  /// The abilities of the Pokemon
  List<String> get abilities;

  /// The moves of the Pokemon
  List<String> get moves;

  /// The base stats of the Pokemon (e.g., {"hp": 78, "attack": 84})
  Map<String, int> get stats;

  /// The evolutions of the Pokemon
  List<String> get evolutions;

  /// The description of the Pokemon
  String get description;

  Map<String, dynamic> toJson();
}
