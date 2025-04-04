import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokemon_bloc.dart';

/// Dialog for filtering Pokemon
class PokemonFilterDialog extends StatefulWidget {
  const PokemonFilterDialog({super.key});

  @override
  State<PokemonFilterDialog> createState() => _PokemonFilterDialogState();
}

class _PokemonFilterDialogState extends State<PokemonFilterDialog> {
  String _selectedFilter = 'type';
  final _filterController = TextEditingController();

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Pokemon'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: _selectedFilter,
            items: const [
              DropdownMenuItem(
                value: 'type',
                child: Text('Type'),
              ),
              DropdownMenuItem(
                value: 'ability',
                child: Text('Ability'),
              ),
              DropdownMenuItem(
                value: 'move',
                child: Text('Move'),
              ),
              DropdownMenuItem(
                value: 'evolution',
                child: Text('Evolution'),
              ),
              DropdownMenuItem(
                value: 'stat',
                child: Text('Stat'),
              ),
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
          TextField(
            controller: _filterController,
            decoration: InputDecoration(
              labelText: 'Enter ${_selectedFilter.capitalize()}',
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final filter = _filterController.text.trim();
            if (filter.isNotEmpty) {
              switch (_selectedFilter) {
                case 'type':
                  context.read<PokemonBloc>().add(
                        GetPokemonsByType(filter),
                      );
                  break;
                case 'ability':
                  context.read<PokemonBloc>().add(
                        GetPokemonsByAbility(filter),
                      );
                  break;
                case 'move':
                  context.read<PokemonBloc>().add(
                        GetPokemonsByMove(filter),
                      );
                  break;
                case 'evolution':
                  context.read<PokemonBloc>().add(
                        GetPokemonsByEvolution(filter),
                      );
                  break;
                case 'stat':
                  context.read<PokemonBloc>().add(
                        GetPokemonsByStat(filter),
                      );
                  break;
                case 'description':
                  context.read<PokemonBloc>().add(
                        GetPokemonsByDescription(filter),
                      );
                  break;
              }
              Navigator.pop(context);
            }
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
