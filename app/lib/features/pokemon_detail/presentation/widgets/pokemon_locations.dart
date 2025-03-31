import 'package:flutter/material.dart';

class PokemonLocations extends StatelessWidget {
  final List<String> locations;

  const PokemonLocations({
    super.key,
    required this.locations,
  });

  String _formatLocationName(String location) {
    return location
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return const Center(
        child: Text('No locations available'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Locations',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return ListTile(
              title: Text(
                _formatLocationName(location),
                style: const TextStyle(fontSize: 16),
              ),
              leading: const Icon(Icons.location_on),
            );
          },
        ),
      ],
    );
  }
}
