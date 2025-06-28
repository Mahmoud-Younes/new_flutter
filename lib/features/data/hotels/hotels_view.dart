

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/core/widgets/custom_drawer.dart';
import 'package:new_flutter/features/Componants/buttons.dart';
import 'package:new_flutter/features/Componants/image_stack.dart';
import 'package:new_flutter/features/maps/testmap.dart';

class viewdata extends StatefulWidget {
  const viewdata({
    super.key,
    required this.hotelsName,
    required this.hotelsDescription,
    required this.imag,
    required this.hotelsPrice, required this.lat, required this.lng,
  });
  final String hotelsName;
  final List<dynamic> imag;
  final String hotelsDescription;
  final String hotelsPrice;
  final double lat;
  final double lng;

  @override
  State<viewdata> createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<viewdata> {


  List<QueryDocumentSnapshot> id = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           endDrawer: CustomDrawer(),

      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.explore,
              color: kMainColor,
            ),
            Text(
              "Egypt.io",
              style: TextStyle(color: kMainColor1),
            ),
          ],
        ),
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.grey[200],
      ),
      body: ListView(
        children: [
        ImageStack(imgList: widget.imag),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.hotelsName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(widget.hotelsDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Center(
            child: Text(widget.hotelsPrice.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: kMainColor)),
          ),
          //location
          Container(
            padding: const EdgeInsets.all(50),
            child: ActionButton(
              width: 50,
              color: Colors.black,
              text: "Get Location",
             onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlaceDetailPage(placesName : widget.hotelsName,placeLat: widget.lat, placeLng: widget.lng)));
              },
              isBold: true,
              isGradient: true,
            ),
          ),
        ],
      ),
    );
  }
}
