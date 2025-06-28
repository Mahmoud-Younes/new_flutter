// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/core/widgets/custom_drawer.dart';
import 'package:new_flutter/features/Data/transport/tansport_view.dart';
import 'package:new_flutter/features/screens/file.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Transport extends StatefulWidget {
  const Transport({super.key});

  @override
  State<Transport> createState() => _TransportState();
}

class _TransportState extends State<Transport> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("transport").get();

    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:  CustomDrawer(),
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
      body: isloading == true
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(color: kMainColor),
                ),
                Text("Loading...."),
              ],
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Public transport",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 160,
                    ),
                    itemBuilder: (context, B) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => viewTransport(
                                    Title: data[B]['Title'],
                                    subtitle: data[B]['subtitle'],
                                    img: data[B]['images'] as List<dynamic>,
                                    price: data[B]['price'],
                                    stations: (data[B]['station'] as List<dynamic>)
                                        .map((station) => Station(
                                              station_name: station['station_name'],
                                              latitude: station['latitude'],
                                              longtitude: station['longtitude'],
                                            ))
                                        .toList(),
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  imageUrl: (data[B]['images']as List<dynamic>).first,
                                  width: 400,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "${data[B]['Title']}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
