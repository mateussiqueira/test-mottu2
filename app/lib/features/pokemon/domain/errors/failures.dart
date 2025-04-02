import 'package:equatable/equatable.dart';

/// Base class for all failures in the Pokemon domain
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when server communication fails
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Failure when cache operations fail
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

/// Failure when network is not available
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

/// Failure when Pokemon is not found
class PokemonNotFoundFailure extends Failure {
  const PokemonNotFoundFailure(String message) : super(message);
}

/// Failure when Pokemon data is invalid
class InvalidPokemonDataFailure extends Failure {
  const InvalidPokemonDataFailure(String message) : super(message);
}
