import 'package:get/get.dart';

class TypeRelations {
  final RxList<String> doubleDamageTo = <String>[].obs;
  final RxList<String> doubleDamageFrom = <String>[].obs;
  final RxList<String> halfDamageTo = <String>[].obs;
  final RxList<String> halfDamageFrom = <String>[].obs;
  final RxList<String> noDamageTo = <String>[].obs;
  final RxList<String> noDamageFrom = <String>[].obs;

  TypeRelations({
    List<String>? doubleDamageTo,
    List<String>? doubleDamageFrom,
    List<String>? halfDamageTo,
    List<String>? halfDamageFrom,
    List<String>? noDamageTo,
    List<String>? noDamageFrom,
  }) {
    this.doubleDamageTo.value = doubleDamageTo ?? [];
    this.doubleDamageFrom.value = doubleDamageFrom ?? [];
    this.halfDamageTo.value = halfDamageTo ?? [];
    this.halfDamageFrom.value = halfDamageFrom ?? [];
    this.noDamageTo.value = noDamageTo ?? [];
    this.noDamageFrom.value = noDamageFrom ?? [];
  }

  factory TypeRelations.fromJson(Map<String, dynamic> json) {
    return TypeRelations(
      doubleDamageTo: (json['double_damage_to'] as List<dynamic>?)
          ?.map((e) => e['name'] as String)
          .toList(),
      doubleDamageFrom: (json['double_damage_from'] as List<dynamic>?)
          ?.map((e) => e['name'] as String)
          .toList(),
      halfDamageTo: (json['half_damage_to'] as List<dynamic>?)
          ?.map((e) => e['name'] as String)
          .toList(),
      halfDamageFrom: (json['half_damage_from'] as List<dynamic>?)
          ?.map((e) => e['name'] as String)
          .toList(),
      noDamageTo: (json['no_damage_to'] as List<dynamic>?)
          ?.map((e) => e['name'] as String)
          .toList(),
      noDamageFrom: (json['no_damage_from'] as List<dynamic>?)
          ?.map((e) => e['name'] as String)
          .toList(),
    );
  }
}
