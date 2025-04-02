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

  /// The abilities of the Pokemon
  List<String> get abilities;

  /// The height of the Pokemon in decimeters
  int get height;

  /// The weight of the Pokemon in hectograms
  int get weight;

  /// The base experience points of the Pokemon
  int? get baseExperience;

  /// The base stats of the Pokemon (e.g., {"hp": 78, "attack": 84})
  Map<String, int> get stats;

  Map<String, dynamic> toJson();
}
