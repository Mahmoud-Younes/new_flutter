import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceDetailPage extends StatefulWidget {
  final double placeLat;
  final double placeLng;
  final String placesName;

  const PlaceDetailPage(
      {Key? key,
      required this.placeLat,
      required this.placeLng,
      required this.placesName})
      : super(key: key);

  @override
  _PlaceDetailPageState createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  GoogleMapController? mapController;
  List<LatLng> polylineCoordinates = [];
  Position? currentLocation;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      // Get device location but we'll override it with fixed coordinates
      final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Set fixed coordinates for Cairo, Egypt
      setState(() {
        currentLocation = location;
      });
      fetchRoute();

      // Add a delay to ensure the map is created before moving camera
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mapController != null) {
          // Adjust camera to show both points
          LatLngBounds bounds = _createBounds(
            LatLng(currentLocation!.latitude, currentLocation!.longitude),
            LatLng(widget.placeLat, widget.placeLng),
          );
          mapController!
              .animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
        }
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // Helper method to create bounds that include both points
  LatLngBounds _createBounds(LatLng point1, LatLng point2) {
    return LatLngBounds(
      southwest: LatLng(
        point1.latitude < point2.latitude ? point1.latitude : point2.latitude,
        point1.longitude < point2.longitude
            ? point1.longitude
            : point2.longitude,
      ),
      northeast: LatLng(
        point1.latitude > point2.latitude ? point1.latitude : point2.latitude,
        point1.longitude > point2.longitude
            ? point1.longitude
            : point2.longitude,
      ),
    );
  }

  Future<void> fetchRoute() async {
    if (currentLocation == null) return;

    try {
      String apiKey = 'AIzaSyDfZ9Tane13TmbMuudVbqaV0DJvOxcxmq0';
      final directions = await fetchDirections(
        currentLocation!.latitude,
        currentLocation!.longitude,
        widget.placeLat,
        widget.placeLng,
        apiKey,
      );
      print("@@@@@@@@@@@@@@@@@$directions");
      if (directions['routes'].isNotEmpty) {
        final points = directions['routes'][0]['overview_polyline']['points'];
        final decodedPoints = decodePolyline(points);

        if (decodedPoints.isNotEmpty) {
          setState(() {
            print(polylineCoordinates);
            polylineCoordinates = decodedPoints;
          });
        }
      } else {
        print("No routes found in the response");
      }
    } catch (e) {
      print("Error fetching route: $e");
    }
  }

  Future<Map<String, dynamic>> fetchDirections(double originLat,
      double originLng, double destLat, double destLng, String apiKey) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destLat,$destLng&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<LatLng> decodePolyline(String polyline) {
    List<LatLng> decodedCoordinates = [];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < polyline.length) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));

      double latitude = lat / 1E5;
      double longitude = lng / 1E5;
      decodedCoordinates.add(LatLng(latitude, longitude));
    }

    return decodedCoordinates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placesName),
        actions: [
          // Add button to focus on destination
          IconButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              mapController?.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(widget.placeLat, widget.placeLng),
                  15,
                ),
              );
            },
          ),
        ],
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    // Start with destination in view instead of current location
                    target: LatLng(widget.placeLat, widget.placeLng),
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      mapController = controller;
                      // Adjust camera after map is created
                      if (currentLocation != null) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          LatLngBounds bounds = _createBounds(
                            LatLng(currentLocation!.latitude,
                                currentLocation!.longitude),
                            LatLng(widget.placeLat, widget.placeLng),
                          );
                          controller.animateCamera(
                              CameraUpdate.newLatLngBounds(bounds, 50));
                        });
                      }
                    });
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('destination'),
                      position: LatLng(widget.placeLat, widget.placeLng),
                      infoWindow: InfoWindow(title: widget.placesName),
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                    if (currentLocation != null)
                      Marker(
                        markerId: const MarkerId('origin'),
                        position: LatLng(currentLocation!.latitude,
                            currentLocation!.longitude),
                        infoWindow: const InfoWindow(title: "Your Location"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                      ),
                  },
                  polylines: {
                    if (polylineCoordinates.isNotEmpty)
                      Polyline(
                        polylineId: const PolylineId('route'),
                        points: polylineCoordinates,
                        color: Colors.blue,
                        width: 5,
                      ),
                  },
                ),
                // Add a button to recenter the map to show both points
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (currentLocation != null && mapController != null) {
                        LatLngBounds bounds = _createBounds(
                          LatLng(currentLocation!.latitude,
                              currentLocation!.longitude),
                          LatLng(widget.placeLat, widget.placeLng),
                        );
                        mapController!.animateCamera(
                            CameraUpdate.newLatLngBounds(bounds, 50));
                      }
                    },
                    child: const Icon(Icons.fullscreen),
                  ),
                ),
              ],
            ),
    );
  }
}
