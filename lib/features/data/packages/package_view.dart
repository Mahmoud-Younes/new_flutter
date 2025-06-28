import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/style/colors.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/core/widgets/custom_drawer.dart';
import 'package:new_flutter/features/Data/packages/Places_view_pac.dart';
import 'package:new_flutter/features/Data/places/places_view.dart';

class packageview extends StatefulWidget {
  const packageview({super.key, required this.id});
  final String id;

  @override
  State<packageview> createState() => _packageviewState();
}

class _packageviewState extends State<packageview> {
  List<QueryDocumentSnapshot> data = [];
  List<QueryDocumentSnapshot> finaldata = [];
  bool isloading = true;
  int index = 0;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("places")
        .get()
        .then((value) {
          log(value.toString());
          for (var element in value.docs) {
            if (element['package_id'].toString() == '1') {
              finaldata.add(element);
            }
          }
          return value;
        });

    await Future.delayed(const Duration(seconds: 1));

    data.addAll(querySnapshot.docs);

    isloading = false;
    setState(() {
      log(data[0].data().toString());
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: CustomDrawer(),
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore, color: AppColors.amber),
              Text("Egypt.io", style: TextStyle(color: AppColors.black)),
            ],
          ),
          iconTheme: const IconThemeData(),
          backgroundColor: Colors.grey[200],
          bottom: TabBar(
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            tabs: const <Widget>[
              Tab(icon: Icon(Icons.place_sharp)),
              Tab(icon: Icon(Icons.hotel_class_sharp)),
            ],
          ),
        ),
        body: Scaffold(
          body:
              isloading == true
                  ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(color: kMainColor),
                      ),
                      Text("Loading...."),
                    ],
                  )
                  : index == 0
                  ? Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Places",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          itemCount: finaldata.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: 160,
                              ),
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      {
                                        return viewplaces(
                                          placesName:
                                              finaldata[i]['places_name'],
                                          placesDescription:
                                              finaldata[i]['places_description'],
                                          images:
                                              finaldata[i]['images']
                                                  as List<dynamic>,
                                          placesPrice:
                                              finaldata[i]['places_price'],
                                          lat: finaldata[i]['latitude'],
                                          lng: finaldata[i]['longtitude'],
                                          fullImage: data[i]["visual_360"],
                                          vrtour: data[i]['VR'],
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        (finaldata[i]['images']
                                                as List<dynamic>)
                                            .first,
                                        width: 400,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        "${finaldata[i]['places_name']}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColors.white,
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
                  )
                  : packageview1(id: widget.id),
        ),
      ),
    );
  }
}
