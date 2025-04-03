class PokemonEntity {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final Map<String, double> stats;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      id: json['id'] ?? 0,
      name: (json['name'] ?? '').toString().replaceFirst(
            json['name'][0],
            json['name'][0].toString().toUpperCase(),
          ),
      imageUrl: json['sprites']?['other']?['official-artwork']
              ?['front_default'] ??
          json['sprites']?['front_default'] ??
          '',
      types: (json['types'] as List?)
              ?.map((type) => type['type']['name'].toString())
              .toList() ??
          [],
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      stats: Map.fromEntries(
        (json['stats'] as List?)?.map(
              (stat) => MapEntry(
                stat['stat']['name'].toString(),
                (stat['base_stat'] as num?)?.toDouble() ?? 0.0,
              ),
            ) ??
            [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprites': {
        'other': {
          'official-artwork': {
            'front_default': imageUrl,
          },
        },
      },
      'types': types
          .map((type) => {
                'type': {'name': type}
              })
          .toList(),
      'height': height,
      'weight': weight,
      'stats': stats.entries
          .map((stat) => {
                'stat': {'name': stat.key},
                'base_stat': stat.value,
              })
          .toList(),
    };
  }
}
