/// Represents the damage relations for a Pokemon type
class TypeRelations {
  /// List of types that are double damage from
  final List<String> doubleDamageFrom;

  /// List of types that are double damage to
  final List<String> doubleDamageTo;

  /// List of types that are half damage from
  final List<String> halfDamageFrom;

  /// List of types that are half damage to
  final List<String> halfDamageTo;

  /// List of types that are no damage from
  final List<String> noDamageFrom;

  /// List of types that are no damage to
  final List<String> noDamageTo;

  /// Constructor for TypeRelations
  TypeRelations({
    required this.doubleDamageFrom,
    required this.doubleDamageTo,
    required this.halfDamageFrom,
    required this.halfDamageTo,
    required this.noDamageFrom,
    required this.noDamageTo,
  });

  /// Creates a TypeRelations instance from JSON data
  factory TypeRelations.fromJson(Map<String, dynamic> json) {
    List<String> getTypeNames(List<dynamic> types) {
      return types.map((type) => type['name'].toString()).toList();
    }

    return TypeRelations(
      doubleDamageFrom: getTypeNames(json['double_damage_from'] ?? []),
      doubleDamageTo: getTypeNames(json['double_damage_to'] ?? []),
      halfDamageFrom: getTypeNames(json['half_damage_from'] ?? []),
      halfDamageTo: getTypeNames(json['half_damage_to'] ?? []),
      noDamageFrom: getTypeNames(json['no_damage_from'] ?? []),
      noDamageTo: getTypeNames(json['no_damage_to'] ?? []),
    );
  }
}
