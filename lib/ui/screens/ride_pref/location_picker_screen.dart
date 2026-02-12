import 'package:blabcar/data/dummy_data.dart';
import 'package:blabcar/models/ride/locations.dart';
import 'package:flutter/material.dart';

class LocationPickerScreen extends StatefulWidget {
  final ValueChanged<Location> onLocationSelected;
  final Location? value;
  const LocationPickerScreen({
    super.key,
    required this.onLocationSelected,
    required this.value,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late List<Location> locations;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    locations = fakeLocations;
    _searchController.text = widget.value?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a location')),
      body: Column(
        children: [
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search location',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                locations = fakeLocations
                    .where(
                      (loc) =>
                          loc.name.toLowerCase().contains(value.toLowerCase()),
                    )
                    .toList();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locations[index].name),
                  onTap: () {
                    widget.onLocationSelected(locations[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
