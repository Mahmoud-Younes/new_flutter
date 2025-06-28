import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class FullView extends StatefulWidget {
  const FullView({super.key, required this.title, required this.url});
  final String title;
  final String url;
  @override
  FullViewState createState() => FullViewState();
}

class FullViewState extends State<FullView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: PanoramaViewer(
        animSpeed: .1,
        //sensorControl: SensorControl.orientation,
        //child: Image.asset('assets/panorama1.webp'),
        child: Image.network(widget.url),
      ),
    );
  }
}
