import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_flutter/features/maps/maps_function.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

class MapSampleState extends State<MapSample> {
  static Position? currentLocation;
  bool isLoading = true;
  String? errorMessage;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.74008263112021, 32.60118436629702),
    zoom: 13.4746,
  );

  Future<void> getLocation() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Check permissions first
      bool hasPermission = await MapFunction.getPermission(context);
      if (!hasPermission) {
        setState(() {
          isLoading = false;
          errorMessage = "Location permission denied";
        });
        return;
      }

      // Get user current position
      currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10), // Add timeout
      );

      setState(() {
        isLoading = false;
      });

      // Move camera to user location
      if (currentLocation != null) {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
              zoom: 15.0,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Error getting location: $e";
      });
      print("Error getting location: $e");
    }
  }

  Future<void> _goToMyLocation() async {
    if (currentLocation != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
            zoom: 15.0,
          ),
        ),
      );
    } else {
      await getLocation();
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: !isLoading,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller.complete(controller);
              });
            },
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      "Getting your location...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          if (errorMessage != null)
            Positioned(
              top: 50,
              left: 16,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToMyLocation,
        child: Icon(Icons.my_location),
      ),
    );
  }
}