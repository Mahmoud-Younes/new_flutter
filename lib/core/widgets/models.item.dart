import 'package:flutter/material.dart';

class Modelsitem extends StatelessWidget {
  const Modelsitem(this.title, this.imageurl, {super.key});
  final String title;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              imageurl,
              height: 270,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Container(
                  height: 270,
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                );
              },
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
              title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

