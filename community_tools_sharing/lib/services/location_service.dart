import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Replace with your actual Google Places API key
  final _places = FlutterGooglePlacesSdk(
    'AIzaSyD8sfOw8pMudOe2AT_JlQw6ws1KxYzZ5ts',
  );

  Future<Position> getCurrentLocation() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Map<String, dynamic>?> searchPlace(String query) async {
    if (query.isEmpty) return null;

    try {
      final res = await _places.findAutocompletePredictions(query);
      if (res.predictions.isEmpty) return null;

      final first = res.predictions.first;
      final details = await _places.fetchPlace(
        first.placeId,
        fields: [PlaceField.Location, PlaceField.AddressComponents],
      );
      final loc = details.place?.latLng;

      return {'address': first.fullText, 'lat': loc?.lat, 'lng': loc?.lng};
    } catch (e) {
      throw Exception('Location search failed: $e');
    }
  }
}
