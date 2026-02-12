import 'package:blabcar/ui/screens/ride_pref/location_picker_screen.dart';
import 'package:blabcar/ui/theme/theme.dart';
import 'package:blabcar/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

import '../../../../models/ride/locations.dart';
import '../../../../models/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///

class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    final init = widget.initRidePref;
    departure = init?.departure;
    arrival = init?.arrival;
    departureDate = init?.departureDate ?? DateTime.now();
    requestedSeats = init?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  String _formatDate(DateTime date) {
    return "${_weekday(date.weekday)} ${date.day} ${_month(date.month)}";
  }

  String _weekday(int w) {
    const names = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return names[w - 1];
  }

  String _month(int m) {
    const names = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return names[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPickerScreen(
                    onLocationSelected: (location) {
                      setState(() {
                        departure = location;
                      });
                    },
                    value: departure,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: BlaColors.neutralLight,
                      ),
                      const SizedBox(width: 10),
                      Text(departure?.name ?? "Choose Departure"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const BlaDivider(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPickerScreen(
                    onLocationSelected: (location) {
                      setState(() {
                        arrival = location;
                      });
                    },
                    value: arrival,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: BlaColors.neutralLight,
                      ),
                      const SizedBox(width: 10),
                      Text(arrival?.name ?? "Choose Arrival"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const BlaDivider(),
          InkWell(
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: departureDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              if (selectedDate != null) {
                setState(() {
                  departureDate = selectedDate;
                });
              }

            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: BlaColors.neutralLight,
                      ),
                      const SizedBox(width: 10),
                      Text(_formatDate(departureDate)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const BlaDivider(),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline, color: BlaColors.neutralLight),
                      const SizedBox(width: 10),
                      Text(
                        "$requestedSeats seat${requestedSeats > 1 ? 's' : ''}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: BlaColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "Search",
              style: BlaTextStyles.button.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
