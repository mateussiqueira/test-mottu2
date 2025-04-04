import 'package:get/get.dart';

import 'type_relations.dart';

/// Interface for Pokemon entity
abstract class IPokemonEntity {
  /// The ID of the Pokemon
  int get id;

  /// The name of the Pokemon
  String get name;

  /// The types of the Pokemon
  List<String> get types;

  /// The sprite URL of the Pokemon
  String get spriteUrl;

  /// The type relations of the Pokemon
  Rx<TypeRelations?> get typeRelations;
}
