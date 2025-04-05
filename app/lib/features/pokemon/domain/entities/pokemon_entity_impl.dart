import 'package:json_annotation/json_annotation.dart';

import 'i_pokemon_entity.dart';

part 'pokemon_entity_impl.g.dart';

/// Implementation of the Pokemon entity
@JsonSerializable()
class PokemonEntityImpl extends IPokemonEntity {
  const PokemonEntityImpl({
    required super.id,
    required super.name,
    required super.types,
    required super.abilities,
    required super.height,
    required super.weight,
    required super.imageUrl,
    required super.stats,
    required super.moves,
    required super.description,
    required super.baseExperience,
    required super.evolutions,
    required super.isDefault,
    required super.order,
    required super.forms,
    required super.gameIndices,
    required super.heldItems,
    required super.locationAreaEncounters,
    required super.species,
    required super.sprites,
  });

  factory PokemonEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$PokemonEntityImplFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PokemonEntityImplToJson(this);

  @override
  String toString() {
    return 'PokemonEntityImpl(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonEntityImpl && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);
}
