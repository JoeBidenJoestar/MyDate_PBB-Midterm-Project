import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationServiceProvider = Provider((ref) => LocationService());

class LocationService {
  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return null;
    } 

    return await Geolocator.getCurrentPosition();
  }

  Future<String?> getCityFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        
        // In many regions (like Indonesia), subAdministrativeArea is the City/Regency 
        // and locality is the smaller district (Kecamatan).
        final rawCity = place.subAdministrativeArea ?? 
                        place.locality ?? 
                        place.administrativeArea ?? 
                        place.country;
        
        if (rawCity != null && rawCity.isNotEmpty) {
          // Clean up common Indonesian prefixes for a cleaner city name
          String city = rawCity
              .replaceAll('Kota Administrasi ', '')
              .replaceAll('Kota ', '')
              .replaceAll('Kabupaten ', '');
          return city.trim();
        }
      }
    } catch (e) {
      print('Error getting city: $e');
      // If it fails (like on some Android emulators), we can just return a fallback or let it return null.
    }
    return null;
  }
}
