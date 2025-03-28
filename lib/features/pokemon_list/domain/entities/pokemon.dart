class Pokemon {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;
  final double height;
  final double weight;
  final List<String> evolutionChain;
  final List<String> locations;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.height,
    required this.weight,
    required this.evolutionChain,
    required this.locations,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      types: List<String>.from(json['types'] as List),
      abilities: List<String>.from(json['abilities'] as List),
      stats: Map<String, int>.from(json['stats'] as Map),
      height: json['height'] as double,
      weight: json['weight'] as double,
      evolutionChain: List<String>.from(json['evolutionChain'] as List),
      locations: List<String>.from(json['locations'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'abilities': abilities,
      'stats': stats,
      'height': height,
      'weight': weight,
      'evolutionChain': evolutionChain,
      'locations': locations,
    };
  }
}
