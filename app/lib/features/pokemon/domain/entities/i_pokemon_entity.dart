import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'i_pokemon_entity.g.dart';

/// Interface for Pokemon entity
abstract class IPokemonEntity extends Equatable {
  final int id;
  final String name;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final String imageUrl;
  final Map<String, int> stats;
  final List<String> moves;
  final String description;
  final int baseExperience;
  final List<String> evolutions;
  final bool isDefault;
  final int order;
  final List<String> forms;
  final List<String> gameIndices;
  final List<String> heldItems;
  final String locationAreaEncounters;
  final String species;
  final Map<String, String> sprites;

  const IPokemonEntity({
    required this.id,
    required this.name,
    required this.types,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.stats,
    required this.moves,
    required this.description,
    required this.baseExperience,
    required this.evolutions,
    required this.isDefault,
    required this.order,
    required this.forms,
    required this.gameIndices,
    required this.heldItems,
    required this.locationAreaEncounters,
    required this.species,
    required this.sprites,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        types,
        abilities,
        height,
        weight,
        imageUrl,
        stats,
        moves,
        description,
        baseExperience,
        evolutions,
        isDefault,
        order,
        forms,
        gameIndices,
        heldItems,
        locationAreaEncounters,
        species,
        sprites,
      ];

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class TypeRelations {
  final List<String> doubleDamageTo;
  final List<String> doubleDamageFrom;
  final List<String> halfDamageTo;
  final List<String> halfDamageFrom;
  final List<String> noDamageTo;
  final List<String> noDamageFrom;

  TypeRelations({
    required this.doubleDamageTo,
    required this.doubleDamageFrom,
    required this.halfDamageTo,
    required this.halfDamageFrom,
    required this.noDamageTo,
    required this.noDamageFrom,
  });

  factory TypeRelations.fromJson(Map<String, dynamic> json) =>
      _$TypeRelationsFromJson(json);

  Map<String, dynamic> toJson() => _$TypeRelationsToJson(this);
}
