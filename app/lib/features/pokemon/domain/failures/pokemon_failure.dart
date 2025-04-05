import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_failure.freezed.dart';

@freezed
class PokemonFailure with _$PokemonFailure {
  const factory PokemonFailure.api({
    required String message,
  }) = _ApiFailure;

  const factory PokemonFailure.network() = _NetworkFailure;

  const factory PokemonFailure.notFound() = _NotFoundFailure;

  const factory PokemonFailure.unknown() = _UnknownFailure;
}
