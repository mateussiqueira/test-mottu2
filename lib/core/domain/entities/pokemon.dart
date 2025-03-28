class Pokemon {
  final List<Ability> abilities;
  final int baseExperience;
  final Cries cries;
  final List<Species> forms;
  final List<GameIndex> gameIndices;
  final int height;
  final List<HeldItem> heldItems;
  final int id;
  final bool isDefault;
  final String locationAreaEncounters;
  final List<Move> moves;
  final String name;
  final int order;
  final List<dynamic> pastAbilities;
  final List<dynamic> pastTypes;
  final Species species;
  final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  Pokemon({
    required this.abilities,
    required this.baseExperience,
    required this.cries,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastAbilities,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      abilities: (json['abilities'] as List<dynamic>)
          .map((ability) => Ability.fromJson(ability as Map<String, dynamic>))
          .toList(),
      baseExperience: json['base_experience'] ?? 0,
      cries: Cries.fromJson(json['cries'] as Map<String, dynamic>),
      forms: (json['forms'] as List<dynamic>)
          .map((form) => Species.fromJson(form as Map<String, dynamic>))
          .toList(),
      gameIndices: (json['game_indices'] as List<dynamic>)
          .map((index) => GameIndex.fromJson(index as Map<String, dynamic>))
          .toList(),
      height: json['height'] ?? 0,
      heldItems: (json['held_items'] as List<dynamic>)
          .map((item) => HeldItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      id: json['id'] ?? 0,
      isDefault: json['is_default'] ?? false,
      locationAreaEncounters: json['location_area_encounters'] ?? '',
      moves: (json['moves'] as List<dynamic>)
          .map((move) => Move.fromJson(move as Map<String, dynamic>))
          .toList(),
      name: json['name'] ?? '',
      order: json['order'] ?? 0,
      pastAbilities: json['past_abilities'] ?? [],
      pastTypes: json['past_types'] ?? [],
      species: Species.fromJson(json['species'] as Map<String, dynamic>),
      sprites: Sprites.fromJson(json['sprites'] as Map<String, dynamic>),
      stats: (json['stats'] as List<dynamic>)
          .map((stat) => Stat.fromJson(stat as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((type) => Type.fromJson(type as Map<String, dynamic>))
          .toList(),
      weight: json['weight'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abilities': abilities.map((ability) => ability.toJson()).toList(),
      'base_experience': baseExperience,
      'cries': cries.toJson(),
      'forms': forms.map((form) => form.toJson()).toList(),
      'game_indices': gameIndices.map((index) => index.toJson()).toList(),
      'height': height,
      'held_items': heldItems.map((item) => item.toJson()).toList(),
      'id': id,
      'is_default': isDefault,
      'location_area_encounters': locationAreaEncounters,
      'moves': moves.map((move) => move.toJson()).toList(),
      'name': name,
      'order': order,
      'past_abilities': pastAbilities,
      'past_types': pastTypes,
      'species': species.toJson(),
      'sprites': sprites.toJson(),
      'stats': stats.map((stat) => stat.toJson()).toList(),
      'types': types.map((type) => type.toJson()).toList(),
      'weight': weight,
    };
  }

  Pokemon copyWith({
    List<Ability>? abilities,
    int? baseExperience,
    Cries? cries,
    List<Species>? forms,
    List<GameIndex>? gameIndices,
    int? height,
    List<HeldItem>? heldItems,
    int? id,
    bool? isDefault,
    String? locationAreaEncounters,
    List<Move>? moves,
    String? name,
    int? order,
    List<dynamic>? pastAbilities,
    List<dynamic>? pastTypes,
    Species? species,
    Sprites? sprites,
    List<Stat>? stats,
    List<Type>? types,
    int? weight,
  }) =>
      Pokemon(
        abilities: abilities ?? this.abilities,
        baseExperience: baseExperience ?? this.baseExperience,
        cries: cries ?? this.cries,
        forms: forms ?? this.forms,
        gameIndices: gameIndices ?? this.gameIndices,
        height: height ?? this.height,
        heldItems: heldItems ?? this.heldItems,
        id: id ?? this.id,
        isDefault: isDefault ?? this.isDefault,
        locationAreaEncounters:
            locationAreaEncounters ?? this.locationAreaEncounters,
        moves: moves ?? this.moves,
        name: name ?? this.name,
        order: order ?? this.order,
        pastAbilities: pastAbilities ?? this.pastAbilities,
        pastTypes: pastTypes ?? this.pastTypes,
        species: species ?? this.species,
        sprites: sprites ?? this.sprites,
        stats: stats ?? this.stats,
        types: types ?? this.types,
        weight: weight ?? this.weight,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'ability': ability.toJson(),
      'is_hidden': isHidden,
      'slot': slot,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  Species copyWith({
    String? name,
    String? url,
  }) =>
      Species(
        name: name ?? this.name,
        url: url ?? this.url,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'latest': latest,
      'legacy': legacy,
    };
  }

  Cries copyWith({
    String? latest,
    String? legacy,
  }) =>
      Cries(
        latest: latest ?? this.latest,
        legacy: legacy ?? this.legacy,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'game_index': gameIndex,
      'version': version.toJson(),
    };
  }

  GameIndex copyWith({
    int? gameIndex,
    Species? version,
  }) =>
      GameIndex(
        gameIndex: gameIndex ?? this.gameIndex,
        version: version ?? this.version,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'version_details':
          versionDetails.map((detail) => detail.toJson()).toList(),
    };
  }

  HeldItem copyWith({
    Species? item,
    List<VersionDetail>? versionDetails,
  }) =>
      HeldItem(
        item: item ?? this.item,
        versionDetails: versionDetails ?? this.versionDetails,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'rarity': rarity,
      'version': version.toJson(),
    };
  }

  VersionDetail copyWith({
    int? rarity,
    Species? version,
  }) =>
      VersionDetail(
        rarity: rarity ?? this.rarity,
        version: version ?? this.version,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'move': move.toJson(),
      'version_group_details':
          versionGroupDetails.map((detail) => detail.toJson()).toList(),
    };
  }

  Move copyWith({
    Species? move,
    List<VersionGroupDetail>? versionGroupDetails,
  }) =>
      Move(
        move: move ?? this.move,
        versionGroupDetails: versionGroupDetails ?? this.versionGroupDetails,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'level_learned_at': levelLearnedAt,
      'move_learn_method': moveLearnMethod.toJson(),
      'order': order,
      'version_group': versionGroup.toJson(),
    };
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
}

class GenerationV {
  final Sprites blackWhite;

  GenerationV({
    required this.blackWhite,
  });

  GenerationV copyWith({
    Sprites? blackWhite,
  }) =>
      GenerationV(
        blackWhite: blackWhite ?? this.blackWhite,
      );
}

class GenerationIv {
  final Sprites diamondPearl;
  final Sprites heartgoldSoulsilver;
  final Sprites platinum;

  GenerationIv({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  GenerationIv copyWith({
    Sprites? diamondPearl,
    Sprites? heartgoldSoulsilver,
    Sprites? platinum,
  }) =>
      GenerationIv(
        diamondPearl: diamondPearl ?? this.diamondPearl,
        heartgoldSoulsilver: heartgoldSoulsilver ?? this.heartgoldSoulsilver,
        platinum: platinum ?? this.platinum,
      );
}

class Versions {
  final GenerationI generationI;
  final GenerationIi generationIi;
  final GenerationIii generationIii;
  final GenerationIv generationIv;
  final GenerationV generationV;
  final Map<String, Home> generationVi;
  final GenerationVii generationVii;
  final GenerationViii generationViii;

  Versions({
    required this.generationI,
    required this.generationIi,
    required this.generationIii,
    required this.generationIv,
    required this.generationV,
    required this.generationVi,
    required this.generationVii,
    required this.generationViii,
  });

  Versions copyWith({
    GenerationI? generationI,
    GenerationIi? generationIi,
    GenerationIii? generationIii,
    GenerationIv? generationIv,
    GenerationV? generationV,
    Map<String, Home>? generationVi,
    GenerationVii? generationVii,
    GenerationViii? generationViii,
  }) =>
      Versions(
        generationI: generationI ?? this.generationI,
        generationIi: generationIi ?? this.generationIi,
        generationIii: generationIii ?? this.generationIii,
        generationIv: generationIv ?? this.generationIv,
        generationV: generationV ?? this.generationV,
        generationVi: generationVi ?? this.generationVi,
        generationVii: generationVii ?? this.generationVii,
        generationViii: generationViii ?? this.generationViii,
      );
}

class Other {
  final DreamWorld dreamWorld;
  final Home home;
  final OfficialArtwork officialArtwork;
  final Sprites showdown;

  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
    required this.showdown,
  });

  Other copyWith({
    DreamWorld? dreamWorld,
    Home? home,
    OfficialArtwork? officialArtwork,
    Sprites? showdown,
  }) =>
      Other(
        dreamWorld: dreamWorld ?? this.dreamWorld,
        home: home ?? this.home,
        officialArtwork: officialArtwork ?? this.officialArtwork,
        showdown: showdown ?? this.showdown,
      );
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
  final Versions versions;
  final Sprites animated;

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
    required this.versions,
    required this.animated,
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
      versions: Versions.fromJson(json['versions'] as Map<String, dynamic>),
      animated: Sprites.fromJson(json['animated'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'back_default': backDefault,
      'back_female': backFemale,
      'back_shiny': backShiny,
      'back_shiny_female': backShinyFemale,
      'front_default': frontDefault,
      'front_female': frontFemale,
      'front_shiny': frontShiny,
      'front_shiny_female': frontShinyFemale,
      'other': other.toJson(),
      'versions': versions.toJson(),
      'animated': animated.toJson(),
    };
  }

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
    Versions? versions,
    Sprites? animated,
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
        versions: versions ?? this.versions,
        animated: animated ?? this.animated,
      );
}

class GenerationI {
  final RedBlue redBlue;
  final RedBlue yellow;

  GenerationI({
    required this.redBlue,
    required this.yellow,
  });

  GenerationI copyWith({
    RedBlue? redBlue,
    RedBlue? yellow,
  }) =>
      GenerationI(
        redBlue: redBlue ?? this.redBlue,
        yellow: yellow ?? this.yellow,
      );
}

class RedBlue {
  final String backDefault;
  final String backGray;
  final String backTransparent;
  final String frontDefault;
  final String frontGray;
  final String frontTransparent;

  RedBlue({
    required this.backDefault,
    required this.backGray,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontGray,
    required this.frontTransparent,
  });

  RedBlue copyWith({
    String? backDefault,
    String? backGray,
    String? backTransparent,
    String? frontDefault,
    String? frontGray,
    String? frontTransparent,
  }) =>
      RedBlue(
        backDefault: backDefault ?? this.backDefault,
        backGray: backGray ?? this.backGray,
        backTransparent: backTransparent ?? this.backTransparent,
        frontDefault: frontDefault ?? this.frontDefault,
        frontGray: frontGray ?? this.frontGray,
        frontTransparent: frontTransparent ?? this.frontTransparent,
      );
}

class GenerationIi {
  final Crystal crystal;
  final Gold gold;
  final Gold silver;

  GenerationIi({
    required this.crystal,
    required this.gold,
    required this.silver,
  });

  GenerationIi copyWith({
    Crystal? crystal,
    Gold? gold,
    Gold? silver,
  }) =>
      GenerationIi(
        crystal: crystal ?? this.crystal,
        gold: gold ?? this.gold,
        silver: silver ?? this.silver,
      );
}

class Crystal {
  final String backDefault;
  final String backShiny;
  final String backShinyTransparent;
  final String backTransparent;
  final String frontDefault;
  final String frontShiny;
  final String frontShinyTransparent;
  final String frontTransparent;

  Crystal({
    required this.backDefault,
    required this.backShiny,
    required this.backShinyTransparent,
    required this.backTransparent,
    required this.frontDefault,
    required this.frontShiny,
    required this.frontShinyTransparent,
    required this.frontTransparent,
  });

  Crystal copyWith({
    String? backDefault,
    String? backShiny,
    String? backShinyTransparent,
    String? backTransparent,
    String? frontDefault,
    String? frontShiny,
    String? frontShinyTransparent,
    String? frontTransparent,
  }) =>
      Crystal(
        backDefault: backDefault ?? this.backDefault,
        backShiny: backShiny ?? this.backShiny,
        backShinyTransparent: backShinyTransparent ?? this.backShinyTransparent,
        backTransparent: backTransparent ?? this.backTransparent,
        frontDefault: frontDefault ?? this.frontDefault,
        frontShiny: frontShiny ?? this.frontShiny,
        frontShinyTransparent:
            frontShinyTransparent ?? this.frontShinyTransparent,
        frontTransparent: frontTransparent ?? this.frontTransparent,
      );
}

class Gold {
  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;
  final String frontTransparent;

  Gold({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
    required this.frontTransparent,
  });

  Gold copyWith({
    String? backDefault,
    String? backShiny,
    String? frontDefault,
    String? frontShiny,
    String? frontTransparent,
  }) =>
      Gold(
        backDefault: backDefault ?? this.backDefault,
        backShiny: backShiny ?? this.backShiny,
        frontDefault: frontDefault ?? this.frontDefault,
        frontShiny: frontShiny ?? this.frontShiny,
        frontTransparent: frontTransparent ?? this.frontTransparent,
      );
}

class GenerationIii {
  final OfficialArtwork emerald;
  final Gold fireredLeafgreen;
  final Gold rubySapphire;

  GenerationIii({
    required this.emerald,
    required this.fireredLeafgreen,
    required this.rubySapphire,
  });

  GenerationIii copyWith({
    OfficialArtwork? emerald,
    Gold? fireredLeafgreen,
    Gold? rubySapphire,
  }) =>
      GenerationIii(
        emerald: emerald ?? this.emerald,
        fireredLeafgreen: fireredLeafgreen ?? this.fireredLeafgreen,
        rubySapphire: rubySapphire ?? this.rubySapphire,
      );
}

class OfficialArtwork {
  final String frontDefault;
  final String frontShiny;

  OfficialArtwork({
    required this.frontDefault,
    required this.frontShiny,
  });

  OfficialArtwork copyWith({
    String? frontDefault,
    String? frontShiny,
  }) =>
      OfficialArtwork(
        frontDefault: frontDefault ?? this.frontDefault,
        frontShiny: frontShiny ?? this.frontShiny,
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

class GenerationVii {
  final DreamWorld icons;
  final Home ultraSunUltraMoon;

  GenerationVii({
    required this.icons,
    required this.ultraSunUltraMoon,
  });

  GenerationVii copyWith({
    DreamWorld? icons,
    Home? ultraSunUltraMoon,
  }) =>
      GenerationVii(
        icons: icons ?? this.icons,
        ultraSunUltraMoon: ultraSunUltraMoon ?? this.ultraSunUltraMoon,
      );
}

class DreamWorld {
  final String frontDefault;
  final String frontFemale;

  DreamWorld({
    required this.frontDefault,
    required this.frontFemale,
  });

  DreamWorld copyWith({
    String? frontDefault,
    String? frontFemale,
  }) =>
      DreamWorld(
        frontDefault: frontDefault ?? this.frontDefault,
        frontFemale: frontFemale ?? this.frontFemale,
      );
}

class GenerationViii {
  final DreamWorld icons;

  GenerationViii({
    required this.icons,
  });

  GenerationViii copyWith({
    DreamWorld? icons,
  }) =>
      GenerationViii(
        icons: icons ?? this.icons,
      );
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

  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'effort': effort,
      'stat': stat.toJson(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': type.toJson(),
    };
  }

  Type copyWith({
    int? slot,
    Species? type,
  }) =>
      Type(
        slot: slot ?? this.slot,
        type: type ?? this.type,
      );
}
