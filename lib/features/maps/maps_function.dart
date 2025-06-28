import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:new_flutter/features/Auth/presentation/pages/login/widgets/login.dart';

class MapFunction {
  //To get Location Permission and requested it if Permission denied
  static Future<bool> getPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      
      if (!serviceEnabled) {
        Login.showSnackBar(context, "Location services are disabled. Please enable location services.");
        return false;
      }

      // Check current permission status
      permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        
        if (permission == LocationPermission.denied) {
          Login.showSnackBar(context, "Location permissions are denied");
          return false;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        Login.showSnackBar(context, "Location permissions are permanently denied. Please enable them in app settings.");
        // Optionally open app settings
        await Geolocator.openAppSettings();
        return false;
      }
      
      return true;
    } catch (e) {
      Login.showSnackBar(context, "Error getting location permission: $e");
      return false;
    }
  }
}

double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  const p = 0.017453292519943295; // Math.PI / 180
  final a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;
  return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
}

String apiName = "Metro";

String getApiName({required String nameFromList}) {
  switch (nameFromList) {
    case 'Metro':
      apiName = 'subway_station';
      break;
      
    case 'Train':
      apiName = 'train_station';
      break;

    case 'Go Bus':
      apiName = 'bus_station';
      break;

    case 'Bus':
      apiName = 'bus_station';
      break;

    default:
      apiName = 'Unknown';
  }
  return apiName;
}