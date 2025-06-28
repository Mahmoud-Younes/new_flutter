import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/core/widgets/custom_drawer.dart';
import 'package:new_flutter/features/Data/places/places_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlacesData extends StatefulWidget {
  const PlacesData({super.key});

  @override
  State<PlacesData> createState() => _PlacesDataState();
}

// ignore: camel_case_types
class _PlacesDataState extends State<PlacesData> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("places").get();
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
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore, color: kMainColor),
            Text("Egypt.io", style: TextStyle(color: kMainColor1)),
          ],
        ),
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.grey[200],
      ),
      body:
          isloading == true
              ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator(color: kMainColor)),
                  Text("Loading...."),
                ],
              )
              : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Places",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      itemCount: data.length,
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
                                      placesName: data[i]['places_name'],
                                      placesDescription:
                                          data[i]['places_description'],
                                      images:
                                          data[i]['images'] as List<dynamic>,
                                      lat: data[i]['latitude'],
                                      lng: data[i]['longtitude'],
                                      placesPrice: data[i]['places_price'],
                                      fullImage: data[i]["visual_360"],
                                      vrtour: data[i]['VR'],
                                    );
                                  }
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        (data[i]['images'] as List<dynamic>)
                                            .first,
                                    width: 400,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) => const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "${data[i]['places_name']}",
                                    style: const TextStyle(
                                      fontSize: 25,
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
