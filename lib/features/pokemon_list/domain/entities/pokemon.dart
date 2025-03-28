class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final int baseExperience;
  final List<String> abilities;
  final Map<String, int> stats;
  final List<String> moves;
  final List<String> heldItems;
  final List<String> gameIndices;
  final List<String> forms;
  final String species;
  final String cries;
  final bool isDefault;
  final String locationAreaEncounters;
  final int order;
  final List<String> pastAbilities;
  final List<String> pastTypes;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.abilities,
    required this.stats,
    required this.moves,
    required this.heldItems,
    required this.gameIndices,
    required this.forms,
    required this.species,
    required this.cries,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.order,
    required this.pastAbilities,
    required this.pastTypes,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['sprites']['front_default'] as String,
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      height: json['height'] as int,
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as int? ?? 0,
      abilities: (json['abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      stats: Map.fromEntries(
        (json['stats'] as List).map(
          (stat) => MapEntry(
            stat['stat']['name'] as String,
            stat['base_stat'] as int,
          ),
        ),
      ),
      moves: (json['moves'] as List)
          .map((move) => move['move']['name'] as String)
          .toList(),
      heldItems: (json['held_items'] as List)
          .map((item) => item['item']['name'] as String)
          .toList(),
      gameIndices: (json['game_indices'] as List)
          .map((index) => index['version']['name'] as String)
          .toList(),
      forms: (json['forms'] as List)
          .map((form) => form['name'] as String)
          .toList(),
      species: json['species']['name'] as String,
      cries: json['cries']['latest'] as String,
      isDefault: json['is_default'] as bool,
      locationAreaEncounters: json['location_area_encounters'] as String,
      order: json['order'] as int,
      pastAbilities: (json['past_abilities'] as List)
          .map((ability) => ability['ability']['name'] as String)
          .toList(),
      pastTypes: (json['past_types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprites': {'front_default': imageUrl},
      'types': types
          .map((type) => {
                'type': {'name': type}
              })
          .toList(),
      'height': height,
      'weight': weight,
      'base_experience': baseExperience,
      'abilities': abilities
          .map((ability) => {
                'ability': {'name': ability}
              })
          .toList(),
      'stats': stats.entries
          .map((entry) => {
                'stat': {'name': entry.key},
                'base_stat': entry.value,
              })
          .toList(),
      'moves': moves
          .map((move) => {
                'move': {'name': move}
              })
          .toList(),
      'held_items': heldItems
          .map((item) => {
                'item': {'name': item}
              })
          .toList(),
      'game_indices': gameIndices
          .map((index) => {
                'version': {'name': index}
              })
          .toList(),
      'forms': forms.map((form) => {'name': form}).toList(),
      'species': {'name': species},
      'cries': {'latest': cries},
      'is_default': isDefault,
      'location_area_encounters': locationAreaEncounters,
      'order': order,
      'past_abilities': pastAbilities
          .map((ability) => {
                'ability': {'name': ability}
              })
          .toList(),
      'past_types': pastTypes
          .map((type) => {
                'type': {'name': type}
              })
          .toList(),
    };
  }
}
