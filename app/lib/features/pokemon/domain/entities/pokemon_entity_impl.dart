import 'i_pokemon_entity.dart';

/// Implementation of the Pokemon entity
class PokemonEntityImpl implements IPokemonEntity {
  final int _id;
  final String _name;
  final int _height;
  final int _weight;
  final List<String> _types;
  final List<String> _abilities;
  final Map<String, int> _stats;
  final Map<String, String?> _sprites;
  final int? _baseExperience;

  PokemonEntityImpl({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<String> types,
    required List<String> abilities,
    required Map<String, int> stats,
    required Map<String, String?> sprites,
    int? baseExperience,
  })  : _id = id,
        _name = name,
        _height = height,
        _weight = weight,
        _types = types,
        _abilities = abilities,
        _stats = stats,
        _sprites = sprites,
        _baseExperience = baseExperience;

  @override
  int get id => _id;

  @override
  String get name => _name;

  @override
  String get imageUrl => _sprites['front_default'] ?? '';

  @override
  List<String> get types => _types;

  @override
  List<String> get abilities => _abilities;

  @override
  int get height => _height;

  @override
  int get weight => _weight;

  @override
  Map<String, int> get stats => _stats;

  @override
  int? get baseExperience => _baseExperience;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'height': _height,
      'weight': _weight,
      'types': _types,
      'abilities': _abilities,
      'stats': _stats,
      'sprites': _sprites,
      'baseExperience': _baseExperience,
    };
  }

  @override
  String toString() {
    return 'PokemonEntityImpl(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonEntityImpl &&
        other._id == _id &&
        other._name == _name;
  }

  @override
  int get hashCode => Object.hash(_id, _name);
}
