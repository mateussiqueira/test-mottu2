class PokemonEntity {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int? baseExperience;
  final List<StatEntity> stats;
  final List<TypeEntity> types;
  final List<AbilityEntity> abilities;
  final List<MoveEntity> moves;
  final SpritesEntity sprites;

  PokemonEntity({
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

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'],
      stats: (json['stats'] as List)
          .map((stat) => StatEntity.fromJson(stat))
          .toList(),
      types: (json['types'] as List)
          .map((type) => TypeEntity.fromJson(type))
          .toList(),
      abilities: (json['abilities'] as List)
          .map((ability) => AbilityEntity.fromJson(ability))
          .toList(),
      moves: (json['moves'] as List)
          .map((move) => MoveEntity.fromJson(move))
          .toList(),
      sprites: SpritesEntity.fromJson(json['sprites']),
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

  @override
  String toString() {
    return 'PokemonEntity(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonEntity &&
        other.id == id &&
        other.name == name &&
        other.height == height &&
        other.weight == weight &&
        other.baseExperience == baseExperience &&
        other.stats == stats &&
        other.types == types &&
        other.abilities == abilities &&
        other.moves == moves &&
        other.sprites == sprites;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        baseExperience.hashCode ^
        stats.hashCode ^
        types.hashCode ^
        abilities.hashCode ^
        moves.hashCode ^
        sprites.hashCode;
  }
}

class StatEntity {
  final int baseStat;
  final String name;

  StatEntity({
    required this.baseStat,
    required this.name,
  });

  factory StatEntity.fromJson(Map<String, dynamic> json) {
    return StatEntity(
      baseStat: json['base_stat'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'StatEntity(baseStat: $baseStat, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatEntity &&
        other.baseStat == baseStat &&
        other.name == name;
  }

  @override
  int get hashCode => baseStat.hashCode ^ name.hashCode;
}

class TypeEntity {
  final String name;

  TypeEntity({
    required this.name,
  });

  factory TypeEntity.fromJson(Map<String, dynamic> json) {
    return TypeEntity(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'TypeEntity(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TypeEntity && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class AbilityEntity {
  final String name;
  final bool isHidden;

  AbilityEntity({
    required this.name,
    required this.isHidden,
  });

  factory AbilityEntity.fromJson(Map<String, dynamic> json) {
    return AbilityEntity(
      name: json['name'],
      isHidden: json['is_hidden'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'is_hidden': isHidden,
    };
  }

  @override
  String toString() {
    return 'AbilityEntity(name: $name, isHidden: $isHidden)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AbilityEntity &&
        other.name == name &&
        other.isHidden == isHidden;
  }

  @override
  int get hashCode => name.hashCode ^ isHidden.hashCode;
}

class MoveEntity {
  final String name;

  MoveEntity({
    required this.name,
  });

  factory MoveEntity.fromJson(Map<String, dynamic> json) {
    return MoveEntity(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'MoveEntity(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoveEntity && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class SpritesEntity {
  final String? frontDefault;
  final OtherEntity? other;

  SpritesEntity({
    this.frontDefault,
    this.other,
  });

  factory SpritesEntity.fromJson(Map<String, dynamic> json) {
    return SpritesEntity(
      frontDefault: json['front_default'],
      other: json['other'] != null ? OtherEntity.fromJson(json['other']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'other': other?.toJson(),
    };
  }

  @override
  String toString() {
    return 'SpritesEntity(frontDefault: $frontDefault, other: $other)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpritesEntity &&
        other.frontDefault == frontDefault &&
        other.other == other;
  }

  @override
  int get hashCode => frontDefault.hashCode ^ other.hashCode;
}

class OtherEntity {
  final OfficialArtworkEntity? officialArtwork;

  OtherEntity({
    this.officialArtwork,
  });

  factory OtherEntity.fromJson(Map<String, dynamic> json) {
    return OtherEntity(
      officialArtwork: json['official-artwork'] != null
          ? OfficialArtworkEntity.fromJson(json['official-artwork'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official-artwork': officialArtwork?.toJson(),
    };
  }

  @override
  String toString() {
    return 'OtherEntity(officialArtwork: $officialArtwork)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OtherEntity && other.officialArtwork == officialArtwork;
  }

  @override
  int get hashCode => officialArtwork.hashCode;
}

class OfficialArtworkEntity {
  final String? frontDefault;

  OfficialArtworkEntity({
    this.frontDefault,
  });

  factory OfficialArtworkEntity.fromJson(Map<String, dynamic> json) {
    return OfficialArtworkEntity(
      frontDefault: json['front_default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
    };
  }

  @override
  String toString() {
    return 'OfficialArtworkEntity(frontDefault: $frontDefault)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OfficialArtworkEntity && other.frontDefault == frontDefault;
  }

  @override
  int get hashCode => frontDefault.hashCode;
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

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json['base_stat'],
        effort: json['effort'],
        stat: Species.fromJson(json['stat']),
      );

  Map<String, dynamic> toJson() => {
        'base_stat': baseStat,
        'effort': effort,
        'stat': stat.toJson(),
      };

  StatEntity toEntity() => StatEntity(
        baseStat: baseStat,
        name: stat.name,
      );

  @override
  String toString() {
    return 'Stat(baseStat: $baseStat, effort: $effort, stat: $stat)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stat &&
        other.baseStat == baseStat &&
        other.effort == effort &&
        other.stat == stat;
  }

  @override
  int get hashCode => baseStat.hashCode ^ effort.hashCode ^ stat.hashCode;
}

class Type {
  final int slot;
  final Species type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json['slot'],
        type: Species.fromJson(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'slot': slot,
        'type': type.toJson(),
      };

  TypeEntity toEntity() => TypeEntity(name: type.name);

  @override
  String toString() {
    return 'Type(slot: $slot, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Type && other.slot == slot && other.type == type;
  }

  @override
  int get hashCode => slot.hashCode ^ type.hashCode;
}

class Sprites {
  final String? frontDefault;

  Sprites({this.frontDefault});

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        frontDefault: json['front_default'],
      );

  Map<String, dynamic> toJson() => {
        'front_default': frontDefault,
      };

  SpritesEntity toEntity() => SpritesEntity(
        frontDefault: frontDefault,
      );

  @override
  String toString() {
    return 'Sprites(frontDefault: $frontDefault)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sprites && other.frontDefault == frontDefault;
  }

  @override
  int get hashCode => frontDefault.hashCode;
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };

  @override
  String toString() {
    return 'Species(name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Species && other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
