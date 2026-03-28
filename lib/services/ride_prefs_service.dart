import 'package:blabcar/models/ride/locations.dart';

import '../data/dummy_data.dart';
import '../models/ride_pref/ride_pref.dart';

////
///   This service handles:
///   - History of the last ride preferences        (to allow users to re-use their last preferences)
///   - Curent selected ride preferences.
///
class RidePrefsService {
  static RidePref? selectedRidePref;

  static List<RidePref> ridePrefsHistory = fakeRidePrefs;

  final List<RidePreferencesListener> _listeners = [];

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void selectPreference(RidePref newPref) {
    selectedRidePref = newPref;
    _notifyListeners(newPref);
  }

  void _notifyListeners(RidePref selectedPref) {
    for (final RidePreferencesListener l in _listeners) {
      l.onPreferenceSelected(selectedPref);
    }
  }
}

abstract class RidePreferencesListener {
  void onPreferenceSelected(RidePref selectedPref);
}

class ConsoleLogger extends RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePref selectedPref) {
    print('Preference changed: ${selectedPref.toString()}');
  }
}

void main() {
  final ridePrefsService = RidePrefsService();

  final logger = ConsoleLogger();
  ridePrefsService.addListener(logger);

  final newPref = RidePref(
    arrival: Location(name: 'Lyon', country: Country.france),
    departure: Location(name: 'Marseille', country: Country.france),
    departureDate: DateTime.now().add(Duration(days: 7)),
    requestedSeats: 2,
  );

  ridePrefsService.selectPreference(newPref);

  final anotherPref = RidePref(
    arrival: Location(name: 'Nice', country: Country.france),
    departure: Location(name: 'Brest', country: Country.france),
    departureDate: DateTime.now().add(Duration(days: 7)),
    requestedSeats: 2,
  );

  ridePrefsService.selectPreference(anotherPref);
}
