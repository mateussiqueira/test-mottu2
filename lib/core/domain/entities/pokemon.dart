import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int baseExperience;
  final List<String> types;
  final List<String> abilities;
  final List<Stat> stats;
  final String imageUrl;

  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        weight,
        baseExperience,
        types,
        abilities,
        stats,
        imageUrl,
      ];
}

class Stat extends Equatable {
  final String name;
  final int baseStat;

  const Stat({
    required this.name,
    required this.baseStat,
  });

  @override
  List<Object?> get props => [name, baseStat];
}

class Ability {
  final Species ability;
  final bool isHidden;
  final int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      ability: Species.fromJson(json['ability'] as Map<String, dynamic>),
      isHidden: json['is_hidden'] ?? false,
      slot: json['slot'] ?? 0,
    );
  }

  Ability copyWith({
    Species? ability,
    bool? isHidden,
    int? slot,
  }) =>
      Ability(
        ability: ability ?? this.ability,
        isHidden: isHidden ?? this.isHidden,
        slot: slot ?? this.slot,
      );

  Map<String, dynamic> toJson() => {
        'ability': ability.toJson(),
        'is_hidden': isHidden,
        'slot': slot,
      };
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
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Species copyWith({
    String? name,
    String? url,
  }) =>
      Species(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}

class Cries {
  final String latest;
  final String legacy;

  Cries({
    required this.latest,
    required this.legacy,
  });

  factory Cries.fromJson(Map<String, dynamic> json) {
    return Cries(
      latest: json['latest'] ?? '',
      legacy: json['legacy'] ?? '',
    );
  }

  Cries copyWith({
    String? latest,
    String? legacy,
  }) =>
      Cries(
        latest: latest ?? this.latest,
        legacy: legacy ?? this.legacy,
      );

  Map<String, dynamic> toJson() => {
        'latest': latest,
        'legacy': legacy,
      };
}

class GameIndex {
  final int gameIndex;
  final Species version;

  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  factory GameIndex.fromJson(Map<String, dynamic> json) {
    return GameIndex(
      gameIndex: json['game_index'] ?? 0,
      version: Species.fromJson(json['version'] as Map<String, dynamic>),
    );
  }

  GameIndex copyWith({
    int? gameIndex,
    Species? version,
  }) =>
      GameIndex(
        gameIndex: gameIndex ?? this.gameIndex,
        version: version ?? this.version,
      );

  Map<String, dynamic> toJson() => {
        'game_index': gameIndex,
        'version': version.toJson(),
      };
}

class HeldItem {
  final Species item;
  final List<VersionDetail> versionDetails;

  HeldItem({
    required this.item,
    required this.versionDetails,
  });

  factory HeldItem.fromJson(Map<String, dynamic> json) {
    return HeldItem(
      item: Species.fromJson(json['item'] as Map<String, dynamic>),
      versionDetails: (json['version_details'] as List<dynamic>)
          .map((detail) =>
              VersionDetail.fromJson(detail as Map<String, dynamic>))
          .toList(),
    );
  }

  HeldItem copyWith({
    Species? item,
    List<VersionDetail>? versionDetails,
  }) =>
      HeldItem(
        item: item ?? this.item,
        versionDetails: versionDetails ?? this.versionDetails,
      );

  Map<String, dynamic> toJson() => {
        'item': item.toJson(),
        'version_details': versionDetails.map((e) => e.toJson()).toList(),
      };
}

class VersionDetail {
  final int rarity;
  final Species version;

  VersionDetail({
    required this.rarity,
    required this.version,
  });

  factory VersionDetail.fromJson(Map<String, dynamic> json) {
    return VersionDetail(
      rarity: json['rarity'] ?? 0,
      version: Species.fromJson(json['version'] as Map<String, dynamic>),
    );
  }

  VersionDetail copyWith({
    int? rarity,
    Species? version,
  }) =>
      VersionDetail(
        rarity: rarity ?? this.rarity,
        version: version ?? this.version,
      );

  Map<String, dynamic> toJson() => {
        'rarity': rarity,
        'version': version.toJson(),
      };
}

class Move {
  final Species move;
  final List<VersionGroupDetail> versionGroupDetails;

  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      move: Species.fromJson(json['move'] as Map<String, dynamic>),
      versionGroupDetails: (json['version_group_details'] as List<dynamic>)
          .map((detail) =>
              VersionGroupDetail.fromJson(detail as Map<String, dynamic>))
          .toList(),
    );
  }

  Move copyWith({
    Species? move,
    List<VersionGroupDetail>? versionGroupDetails,
  }) =>
      Move(
        move: move ?? this.move,
        versionGroupDetails: versionGroupDetails ?? this.versionGroupDetails,
      );

  Map<String, dynamic> toJson() => {
        'move': move.toJson(),
        'version_group_details':
            versionGroupDetails.map((e) => e.toJson()).toList(),
      };
}

class VersionGroupDetail {
  final int levelLearnedAt;
  final Species moveLearnMethod;
  final int order;
  final Species versionGroup;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.order,
    required this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) {
    return VersionGroupDetail(
      levelLearnedAt: json['level_learned_at'] ?? 0,
      moveLearnMethod:
          Species.fromJson(json['move_learn_method'] as Map<String, dynamic>),
      order: json['order'] ?? 0,
      versionGroup:
          Species.fromJson(json['version_group'] as Map<String, dynamic>),
    );
  }

  VersionGroupDetail copyWith({
    int? levelLearnedAt,
    Species? moveLearnMethod,
    int? order,
    Species? versionGroup,
  }) =>
      VersionGroupDetail(
        levelLearnedAt: levelLearnedAt ?? this.levelLearnedAt,
        moveLearnMethod: moveLearnMethod ?? this.moveLearnMethod,
        order: order ?? this.order,
        versionGroup: versionGroup ?? this.versionGroup,
      );

  Map<String, dynamic> toJson() => {
        'level_learned_at': levelLearnedAt,
        'move_learn_method': moveLearnMethod.toJson(),
        'order': order,
        'version_group': versionGroup.toJson(),
      };
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
      baseStat: json['base_stat'] ?? 0,
      effort: json['effort'] ?? 0,
      stat: Species.fromJson(json['stat'] as Map<String, dynamic>),
    );
  }

  Stat copyWith({
    int? baseStat,
    int? effort,
    Species? stat,
  }) =>
      Stat(
        baseStat: baseStat ?? this.baseStat,
        effort: effort ?? this.effort,
        stat: stat ?? this.stat,
      );

  Map<String, dynamic> toJson() => {
        'base_stat': baseStat,
        'effort': effort,
        'stat': stat.toJson(),
      };
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
      slot: json['slot'] ?? 0,
      type: Species.fromJson(json['type'] as Map<String, dynamic>),
    );
  }

  Type copyWith({
    int? slot,
    Species? type,
  }) =>
      Type(
        slot: slot ?? this.slot,
        type: type ?? this.type,
      );

  Map<String, dynamic> toJson() => {
        'slot': slot,
        'type': type.toJson(),
      };
}

class Sprites {
  final String backDefault;
  final String backFemale;
  final String backShiny;
  final String backShinyFemale;
  final String frontDefault;
  final String frontFemale;
  final String frontShiny;
  final String frontShinyFemale;
  final Other other;

  Sprites({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
    required this.other,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      backDefault: json['back_default'] ?? '',
      backFemale: json['back_female'] ?? '',
      backShiny: json['back_shiny'] ?? '',
      backShinyFemale: json['back_shiny_female'] ?? '',
      frontDefault: json['front_default'] ?? '',
      frontFemale: json['front_female'] ?? '',
      frontShiny: json['front_shiny'] ?? '',
      frontShinyFemale: json['front_shiny_female'] ?? '',
      other: Other.fromJson(json['other'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'back_default': backDefault,
        'back_female': backFemale,
        'back_shiny': backShiny,
        'back_shiny_female': backShinyFemale,
        'front_default': frontDefault,
        'front_female': frontFemale,
        'front_shiny': frontShiny,
        'front_shiny_female': frontShinyFemale,
        'other': other.toJson(),
      };

  Sprites copyWith({
    String? backDefault,
    String? backFemale,
    String? backShiny,
    String? backShinyFemale,
    String? frontDefault,
    String? frontFemale,
    String? frontShiny,
    String? frontShinyFemale,
    Other? other,
  }) =>
      Sprites(
        backDefault: backDefault ?? this.backDefault,
        backFemale: backFemale ?? this.backFemale,
        backShiny: backShiny ?? this.backShiny,
        backShinyFemale: backShinyFemale ?? this.backShinyFemale,
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
        frontShiny: frontShiny ?? this.frontShiny,
        frontShinyFemale: frontShinyFemale ?? this.frontShinyFemale,
        other: other ?? this.other,
      );
}

class Other {
  final DreamWorld dreamWorld;
  final Home home;
  final OfficialArtwork officialArtwork;

  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
  });

  factory Other.fromJson(Map<String, dynamic> json) {
    return Other(
      dreamWorld:
          DreamWorld.fromJson(json['dream_world'] as Map<String, dynamic>),
      home: Home.fromJson(json['home'] as Map<String, dynamic>),
      officialArtwork: OfficialArtwork.fromJson(
          json['official-artwork'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'dream_world': dreamWorld.toJson(),
        'home': home.toJson(),
        'official-artwork': officialArtwork.toJson(),
      };

  Other copyWith({
    DreamWorld? dreamWorld,
    Home? home,
    OfficialArtwork? officialArtwork,
  }) =>
      Other(
        dreamWorld: dreamWorld ?? this.dreamWorld,
        home: home ?? this.home,
        officialArtwork: officialArtwork ?? this.officialArtwork,
      );
}

class DreamWorld {
  final String frontDefault;
  final String frontFemale;

  DreamWorld({
    required this.frontDefault,
    required this.frontFemale,
  });

  factory DreamWorld.fromJson(Map<String, dynamic> json) {
    return DreamWorld(
      frontDefault: json['front_default'] ?? '',
      frontFemale: json['front_female'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'front_default': frontDefault,
        'front_female': frontFemale,
      };

  DreamWorld copyWith({
    String? frontDefault,
    String? frontFemale,
  }) =>
      DreamWorld(
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
      );
}

class Home {
  final String frontDefault;
  final String frontFemale;
  final String frontShiny;
  final String frontShinyFemale;

  Home({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      frontDefault: json['front_default'] ?? '',
      frontFemale: json['front_female'] ?? '',
      frontShiny: json['front_shiny'] ?? '',
      frontShinyFemale: json['front_shiny_female'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'front_default': frontDefault,
        'front_female': frontFemale,
        'front_shiny': frontShiny,
        'front_shiny_female': frontShinyFemale,
      };

  Home copyWith({
    String? frontDefault,
    String? frontFemale,
    String? frontShiny,
    String? frontShinyFemale,
  }) =>
      Home(
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
        frontShiny: frontShiny ?? this.frontShiny,
        frontShinyFemale: frontShinyFemale ?? this.frontShinyFemale,
      );
}

class OfficialArtwork {
  final String frontDefault;
  final String frontShiny;

  OfficialArtwork({
    required this.frontDefault,
    required this.frontShiny,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) {
    return OfficialArtwork(
      frontDefault: json['front_default'] ?? '',
      frontShiny: json['front_shiny'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'front_default': frontDefault,
        'front_shiny': frontShiny,
      };

  OfficialArtwork copyWith({
    String? frontDefault,
    String? frontShiny,
  }) =>
      OfficialArtwork(
        frontDefault: frontDefault ?? this.frontDefault,
        frontShiny: frontShiny ?? this.frontShiny,
      );
}