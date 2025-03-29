import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi/core/domain/validators/pokemon_validator.dart';

void main() {
  group('PokemonValidator', () {
    group('validateId', () {
      test('should return success when id is valid', () {
        final result = PokemonValidator.validateId(1);
        expect(result.isSuccess, true);
        expect(result.data, 1);
      });

      test('should return failure when id is zero', () {
        final result = PokemonValidator.validateId(0);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_ID');
      });

      test('should return failure when id is negative', () {
        final result = PokemonValidator.validateId(-1);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_ID');
      });
    });

    group('validateName', () {
      test('should return success when name is valid', () {
        final result = PokemonValidator.validateName('Pikachu');
        expect(result.isSuccess, true);
        expect(result.data, 'Pikachu');
      });

      test('should return failure when name is empty', () {
        final result = PokemonValidator.validateName('');
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_NAME');
      });
    });

    group('validateType', () {
      test('should return success when type is valid', () {
        final result = PokemonValidator.validateType('Electric');
        expect(result.isSuccess, true);
        expect(result.data, 'Electric');
      });

      test('should return failure when type is empty', () {
        final result = PokemonValidator.validateType('');
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_TYPE');
      });
    });

    group('validateAbility', () {
      test('should return success when ability is valid', () {
        final result = PokemonValidator.validateAbility('Static');
        expect(result.isSuccess, true);
        expect(result.data, 'Static');
      });

      test('should return failure when ability is empty', () {
        final result = PokemonValidator.validateAbility('');
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_ABILITY');
      });
    });

    group('validateTypes', () {
      test('should return success when types list is valid', () {
        final result = PokemonValidator.validateTypes(['Electric', 'Flying']);
        expect(result.isSuccess, true);
        expect(result.data, ['Electric', 'Flying']);
      });

      test('should return failure when types list is empty', () {
        final result = PokemonValidator.validateTypes([]);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_TYPES');
      });

      test('should return failure when any type is invalid', () {
        final result = PokemonValidator.validateTypes(['Electric', '']);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_TYPE');
      });
    });

    group('validateAbilities', () {
      test('should return success when abilities list is valid', () {
        final result =
            PokemonValidator.validateAbilities(['Static', 'Lightning Rod']);
        expect(result.isSuccess, true);
        expect(result.data, ['Static', 'Lightning Rod']);
      });

      test('should return failure when abilities list is empty', () {
        final result = PokemonValidator.validateAbilities([]);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_ABILITIES');
      });

      test('should return failure when any ability is invalid', () {
        final result = PokemonValidator.validateAbilities(['Static', '']);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_ABILITY');
      });
    });

    group('validateHeight', () {
      test('should return success when height is valid', () {
        final result = PokemonValidator.validateHeight(0.4);
        expect(result.isSuccess, true);
        expect(result.data, 0.4);
      });

      test('should return failure when height is zero', () {
        final result = PokemonValidator.validateHeight(0);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_HEIGHT');
      });

      test('should return failure when height is negative', () {
        final result = PokemonValidator.validateHeight(-0.4);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_HEIGHT');
      });
    });

    group('validateWeight', () {
      test('should return success when weight is valid', () {
        final result = PokemonValidator.validateWeight(6.0);
        expect(result.isSuccess, true);
        expect(result.data, 6.0);
      });

      test('should return failure when weight is zero', () {
        final result = PokemonValidator.validateWeight(0);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_WEIGHT');
      });

      test('should return failure when weight is negative', () {
        final result = PokemonValidator.validateWeight(-6.0);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_WEIGHT');
      });
    });

    group('validateBaseExperience', () {
      test('should return success when base experience is valid', () {
        final result = PokemonValidator.validateBaseExperience(112);
        expect(result.isSuccess, true);
        expect(result.data, 112);
      });

      test('should return success when base experience is zero', () {
        final result = PokemonValidator.validateBaseExperience(0);
        expect(result.isSuccess, true);
        expect(result.data, 0);
      });

      test('should return failure when base experience is negative', () {
        final result = PokemonValidator.validateBaseExperience(-112);
        expect(result.isFailure, true);
        expect(result.error?.code, 'INVALID_BASE_EXPERIENCE');
      });
    });
  });
}
