import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_flutter/features/screens/file.dart';

class TransportationMap extends StatefulWidget {
  const TransportationMap({super.key, required this.stations});

  final List<Station> stations;

  @override
  _TransportationMapState createState() => _TransportationMapState();
}

class _TransportationMapState extends State<TransportationMap> {
  late GoogleMapController mapController;
  List<Marker> allMarkers = [];
  LatLng? userLocation;
  LatLng? nearestStation;
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    determineUserLocation();
  }

  Future<void> determineUserLocation() async {
    // Determine the user's current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
    fetchMetroStations();
  }

  Future<void> fetchMetroStations() async {
    // Fetch all metro stations from the Google Places API
    if (userLocation == null) return;

   

        if (widget.stations.isNotEmpty) {
          setState(() {
            allMarkers = widget.stations.map((station) {
              return Marker(
                markerId: MarkerId(station.station_name),
                position: LatLng(station.latitude, station.longtitude),
                infoWindow: InfoWindow(title: station.station_name),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              );
            }).toList();
            nearestStation = findNearestStation();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No stations found in this area')),
          );
        }
      }
    
  

  LatLng? findNearestStation() {
    // Find the nearest metro station to the user's location
    if (userLocation == null) return null;

    double minDistance = double.infinity;
    LatLng? nearestStation;

    for (Marker marker in allMarkers) {
      double distance = Geolocator.distanceBetween(
        userLocation!.latitude,
        userLocation!.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
        nearestStation = marker.position;
      }
    }

    return nearestStation;
  }

    Future<void> fetchDirections(LatLng destination) async {
    if (userLocation == null) return;

    setState(() {
      polylineCoordinates = [
        userLocation!,
        destination,
      ];
    });
  }


  List<List<double>> decodeEncodedPolyline(String encoded) {
    // Decode encoded polyline points
    List<List<double>> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add([lat / 1E5, lng / 1E5]);
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' map')),
      body: userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: userLocation!,
                zoom: 13.4,
              ),
              markers: Set<Marker>.of(allMarkers),
              polylines: <Polyline>{
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: Colors.red,
                  points: polylineCoordinates,
                  width: 5,
                ),
              },
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (nearestStation != null) {
            fetchDirections(nearestStation!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not find nearest station')),
            );
          }
        },
        child: const Icon(Icons.near_me),
      ),
    );
  }
}


