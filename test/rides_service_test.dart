import 'package:blabcar/models/ride/locations.dart';
import 'package:blabcar/services/rides_service.dart';

void main() {
  final tests = RidesService.filterBy(
    departure: Location(name: "Dijon", country: Country.france),
    seatRequested: 2,
  );
  for (final test in tests) {
    print(test);
  }
}
