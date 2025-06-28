import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/core/widgets/custom_drawer.dart';
import 'package:new_flutter/features/Data/hotels/hotels_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotelsData extends StatefulWidget {
  const HotelsData({super.key});

  @override
  State<HotelsData> createState() => _HotelsDataState();
}

class _HotelsDataState extends State<HotelsData> {

  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("hotels").get();
    await Future.delayed(const Duration(seconds: 1));

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
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "Hotels",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    itemBuilder: (context, v) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => viewdata(
                                  hotelsName: data[v]['hotel_name'],
                                  hotelsDescription: data[v]
                                      ['hotel_description'],
                                  imag: data[v]['images']as List<dynamic>,
                                   lat:  data[v]['latitude'],
                                    lng:  data[v]['longitude'],
                                  hotelsPrice: data[v]['hotel_price'])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  imageUrl: (data[v]['images'] as List<dynamic>).first,
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
                                      color: Colors.black.withValues(alpha: 0.4),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "${data[v]['hotel_name']}",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ))
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
