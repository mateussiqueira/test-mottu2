
import 'dart:async' as _i4;

import 'package:mobile/features/pokemon_list/data/datasources/pokemon_remote_data_source.dart'
    as _i3;
import 'package:mobile/features/pokemon_list/data/models/pokemon_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;


class _FakePokemonModel_0 extends _i1.SmartFake implements _i2.PokemonModel {
  _FakePokemonModel_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class MockPokemonRemoteDataSource extends _i1.Mock
    implements _i3.PokemonRemoteDataSource {
  MockPokemonRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.PokemonModel>> getPokemons({
    int? offset = 0,
    int? limit = 20,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemons, [], {
              #offset: offset,
              #limit: limit,
            }),
            returnValue: _i4.Future<List<_i2.PokemonModel>>.value(
              <_i2.PokemonModel>[],
            ),
          )
          as _i4.Future<List<_i2.PokemonModel>>);

  @override
  _i4.Future<_i2.PokemonModel> getPokemonById(int? id) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonById, [id]),
            returnValue: _i4.Future<_i2.PokemonModel>.value(
              _FakePokemonModel_0(
                this,
                Invocation.method(#getPokemonById, [id]),
              ),
            ),
          )
          as _i4.Future<_i2.PokemonModel>);

  @override
  _i4.Future<_i2.PokemonModel> getPokemonByName(String? name) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonByName, [name]),
            returnValue: _i4.Future<_i2.PokemonModel>.value(
              _FakePokemonModel_0(
                this,
                Invocation.method(#getPokemonByName, [name]),
              ),
            ),
          )
          as _i4.Future<_i2.PokemonModel>);

  @override
  _i4.Future<List<_i2.PokemonModel>> searchPokemons(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#searchPokemons, [query]),
            returnValue: _i4.Future<List<_i2.PokemonModel>>.value(
              <_i2.PokemonModel>[],
            ),
          )
          as _i4.Future<List<_i2.PokemonModel>>);

  @override
  _i4.Future<List<_i2.PokemonModel>> getPokemonsByType(String? type) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonsByType, [type]),
            returnValue: _i4.Future<List<_i2.PokemonModel>>.value(
              <_i2.PokemonModel>[],
            ),
          )
          as _i4.Future<List<_i2.PokemonModel>>);

  @override
  _i4.Future<List<_i2.PokemonModel>> getPokemonsByAbility(String? ability) =>
      (super.noSuchMethod(
            Invocation.method(#getPokemonsByAbility, [ability]),
            returnValue: _i4.Future<List<_i2.PokemonModel>>.value(
              <_i2.PokemonModel>[],
            ),
          )
          as _i4.Future<List<_i2.PokemonModel>>);

  @override
  _i4.Future<void> clearCache() =>
      (super.noSuchMethod(
            Invocation.method(#clearCache, []),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);
}
