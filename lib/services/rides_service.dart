import 'package:blabcar/models/ride/locations.dart';

import '../data/dummy_data.dart';
import '../models/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;

  static List<Ride> filterByDeparture(Location departure) {
    return allRides
        .where((ride) => ride.departureLocation == departure)
        .toList();
  }

  static List<Ride> filterBySeatRequested(int seatRequested) {
    return allRides
        .where((ride) => ride.availableSeats == seatRequested)
        .toList();
  }

  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    if (departure != null && seatRequested == null) {
      return RidesService.filterByDeparture(departure);
    }
    if (departure == null && seatRequested != null) {
      return RidesService.filterBySeatRequested(seatRequested);
    }
    if (departure != null && seatRequested != null) {
      return allRides
          .where(
            (ride) =>
                ride.availableSeats == seatRequested &&
                ride.departureLocation == departure,
          )
          .toList();
    }
    return allRides;
  }
}
