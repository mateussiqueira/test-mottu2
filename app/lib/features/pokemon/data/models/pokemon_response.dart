import 'package:json_annotation/json_annotation.dart';

import 'pokemon_model.dart';

part 'pokemon_response.g.dart';

/// Model for Pokemon API response
@JsonSerializable()
class PokemonResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonModel> results;

  const PokemonResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonResponseToJson(this);
}
