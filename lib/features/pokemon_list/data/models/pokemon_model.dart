import '../../domain/entities/pokemon.dart';

class PokemonModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int? baseExperience;
  final List<Stat> stats;
  final List<Type> types;
  final List<Ability> abilities;
  final List<Move> moves;
  final Sprites sprites;

  PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.stats,
    required this.types,
    required this.abilities,
    required this.moves,
    required this.sprites,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'],
      stats:
          (json['stats'] as List).map((stat) => Stat.fromJson(stat)).toList(),
      types:
          (json['types'] as List).map((type) => Type.fromJson(type)).toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => Ability.fromJson(ability))
          .toList(),
      moves:
          (json['moves'] as List).map((move) => Move.fromJson(move)).toList(),
      sprites: Sprites.fromJson(json['sprites']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'base_experience': baseExperience,
      'stats': stats.map((stat) => stat.toJson()).toList(),
      'types': types.map((type) => type.toJson()).toList(),
      'abilities': abilities.map((ability) => ability.toJson()).toList(),
      'moves': moves.map((move) => move.toJson()).toList(),
      'sprites': sprites.toJson(),
    };
  }

  PokemonEntity toEntity() {
    return PokemonEntity(
      id: id,
      name: name,
      height: height,
      weight: weight,
      baseExperience: baseExperience,
      stats: stats.map((stat) => stat.toEntity()).toList(),
      types: types.map((type) => type.toEntity()).toList(),
      abilities: abilities.map((ability) => ability.toEntity()).toList(),
      moves: moves.map((move) => move.toEntity()).toList(),
      sprites: sprites.toEntity(),
    );
  }
}

class Stat {
  final int baseStat;
  final int effort;
  final Species stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: Species.fromJson(json['stat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'effort': effort,
      'stat': stat.toJson(),
    };
  }

  StatEntity toEntity() {
    return StatEntity(
      baseStat: baseStat,
      name: stat.name,
    );
  }
}

class Type {
  final int slot;
  final Species type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      slot: json['slot'],
      type: Species.fromJson(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': type.toJson(),
    };
  }

  TypeEntity toEntity() {
    return TypeEntity(name: type.name);
  }
}

class Ability {
  final bool isHidden;
  final int slot;
  final Species ability;

  Ability({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      isHidden: json['is_hidden'],
      slot: json['slot'],
      ability: Species.fromJson(json['ability']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_hidden': isHidden,
      'slot': slot,
      'ability': ability.toJson(),
    };
  }

  AbilityEntity toEntity() {
    return AbilityEntity(
      name: ability.name,
      isHidden: isHidden,
    );
  }
}

class Move {
  final Species move;
  final List<Map<String, dynamic>> versionGroupDetails;

  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      move: Species.fromJson(json['move']),
      versionGroupDetails:
          List<Map<String, dynamic>>.from(json['version_group_details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'move': move.toJson(),
      'version_group_details': versionGroupDetails,
    };
  }

  MoveEntity toEntity() {
    return MoveEntity(name: move.name);
  }
}

class Sprites {
  final String? frontDefault;
  final Other? other;

  Sprites({
    this.frontDefault,
    this.other,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'],
      other: json['other'] != null ? Other.fromJson(json['other']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'other': other?.toJson(),
    };
  }

  SpritesEntity toEntity() {
    return SpritesEntity(
      frontDefault: frontDefault,
      other: other?.toEntity(),
    );
  }
}

class Other {
  final OfficialArtwork? officialArtwork;

  Other({
    this.officialArtwork,
  });

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(
      officialArtwork: json['official-artwork'] != null
          ? OfficialArtwork.fromJson(json['official-artwork'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official-artwork': officialArtwork?.toJson(),
    };
  }

  OtherEntity toEntity() {
    return OtherEntity(
      officialArtwork: officialArtwork?.toEntity(),
    );
  }
}

class OfficialArtwork {
  final String? frontDefault;

  OfficialArtwork({
    this.frontDefault,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) {
    return OfficialArtwork(
      frontDefault: json['front_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
    };
  }

  OfficialArtworkEntity toEntity() {
    return OfficialArtworkEntity(
      frontDefault: frontDefault,
    );
  }
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
