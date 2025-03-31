abstract class PokemonEntity {
  final int id;
  final String name;
  final List<String> types;
  final List<String> abilities;
  final double height;
  final double weight;
  final double baseExperience;
  final String imageUrl;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.imageUrl,
  });
}
