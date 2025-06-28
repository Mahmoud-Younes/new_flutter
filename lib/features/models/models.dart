import 'package:flutter/material.dart';

class Models {
  final String id;
  final String title;
  final String imageurl;
  final Widget goFor;

  const Models({
    required this.goFor,
    required this.id,
    required this.title,
    required this.imageurl,
  });
}
