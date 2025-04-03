import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';

class PokemonFilterDialog extends StatefulWidget {
  const PokemonFilterDialog({super.key});

  @override
  State<PokemonFilterDialog> createState() => _PokemonFilterDialogState();
}

class _PokemonFilterDialogState extends State<PokemonFilterDialog> {
  String _selectedFilter = 'type';
  final _textController = TextEditingController();
  final _statValueController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _statValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Pokemon'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedFilter,
            items: const [
              DropdownMenuItem(value: 'type', child: Text('Type')),
              DropdownMenuItem(value: 'ability', child: Text('Ability')),
              DropdownMenuItem(value: 'move', child: Text('Move')),
              DropdownMenuItem(value: 'evolution', child: Text('Evolution')),
              DropdownMenuItem(value: 'stat', child: Text('Stat')),
              DropdownMenuItem(
                value: 'description',
                child: Text('Description'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedFilter = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          if (_selectedFilter == 'stat') ...[
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Stat Name',
                hintText: 'e.g., hp, attack, defense',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _statValueController,
              decoration: const InputDecoration(
                labelText: 'Minimum Value',
                hintText: 'e.g., 100',
              ),
              keyboardType: TextInputType.number,
            ),
          ] else
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter ${_selectedFilter.capitalize()}',
                hintText: 'e.g., ${_getHintText()}',
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _applyFilter,
          child: const Text('Apply'),
        ),
      ],
    );
  }

  String _getHintText() {
    switch (_selectedFilter) {
      case 'type':
        return 'fire, water, grass';
      case 'ability':
        return 'blaze, torrent, overgrow';
      case 'move':
        return 'tackle, ember, bubble';
      case 'evolution':
        return 'charmander, charmeleon, charizard';
      case 'description':
        return 'fire-breathing dragon';
      default:
        return '';
    }
  }

  void _applyFilter() {
    if (_textController.text.isEmpty) {
      return;
    }

    final bloc = context.read<PokemonBloc>();

    switch (_selectedFilter) {
      case 'type':
        bloc.add(GetPokemonsByType(_textController.text));
        break;
      case 'ability':
        bloc.add(GetPokemonsByAbility(_textController.text));
        break;
      case 'move':
        bloc.add(GetPokemonsByMove(_textController.text));
        break;
      case 'evolution':
        bloc.add(GetPokemonsByEvolution(_textController.text));
        break;
      case 'stat':
        if (_statValueController.text.isEmpty) {
          return;
        }
        bloc.add(GetPokemonsByStat(
          _textController.text,
          int.parse(_statValueController.text),
        ));
        break;
      case 'description':
        bloc.add(GetPokemonsByDescription(_textController.text));
        break;
    }

    Navigator.pop(context);
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
