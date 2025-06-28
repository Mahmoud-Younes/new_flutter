// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/core/widgets/custom_drawer.dart';
import 'package:new_flutter/features/Componants/buttons.dart';
import 'package:new_flutter/features/Componants/image_stack.dart';
import 'package:new_flutter/features/screens/file.dart';
import 'package:new_flutter/features/maps/map.dart';
import 'package:new_flutter/features/maps/maps_function.dart';

class viewTransport extends StatefulWidget {
  const viewTransport({
    super.key,
    required this.Title,
    required this.subtitle,
    required this.img,
    required this.price, required this.stations

  });
  final String Title;
  final List<dynamic> img;
  final List<Station> stations;
  final String subtitle;
  final String price;


  @override
  State<viewTransport> createState() => _viewTransportState();
}


class _viewTransportState extends State<viewTransport> {


@override
  void initState() {
    super.initState();
    getApiName(nameFromList: widget.Title);
  }


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
          const SizedBox(height: 15),
      ImageStack(imgList: widget.img),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              widget.Title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(widget.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 30),
          Center(
            child: Text(widget.price.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: kMainColor)),
          ),
          const SizedBox(height: 8),
          //location
          Container(
            padding: const EdgeInsets.all(50),
            child: ActionButton(
              width: 60,
              color: Colors.black,
              text: "Get Location",
              onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  TransportationMap(stations:widget.stations)));
              
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
