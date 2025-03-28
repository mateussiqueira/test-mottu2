class Pokemon {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;
  final int height;
  final int weight;
  final List<String> evolutionChain;
  final List<String> locations;
  final List<Map<String, dynamic>> moves;

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
    required this.moves,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      imageUrl: json['sprites']?['other']?['official-artwork']
              ?['front_default'] ??
          '',
      types: (json['types'] as List<dynamic>?)
              ?.map((type) => type['type']['name'] as String)
              .toList() ??
          [],
      abilities: (json['abilities'] as List<dynamic>?)
              ?.map((ability) => ability['ability']['name'] as String)
              .toList() ??
          [],
      stats: (json['stats'] as List<dynamic>?)?.fold<Map<String, int>>({},
              (map, stat) {
            map[stat['stat']['name']] = stat['base_stat'];
            return map;
          }) ??
          {},
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      evolutionChain: const [], // Will be populated from species endpoint
      locations: const [], // Will be populated from location endpoint
      moves: (json['moves'] as List<dynamic>?)
              ?.map((move) => {
                    'name': move['move']['name'],
                    'level': move['version_group_details']?[0]
                        ?['level_learned_at'],
                    'method': move['version_group_details']?[0]
                        ?['move_learn_method']?['name'],
                  })
              .toList() ??
          [],
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
      'moves': moves,
    };
  }
}
