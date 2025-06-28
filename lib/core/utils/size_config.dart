import 'package:flutter/material.dart';
class Sizeconfig{
static double?screenwidth;
static double? screenheight;
static double? defaultSize;
static Orientation? orientation;

void init(BuildContext context) {
  screenwidth= MediaQuery.of(context).size.width;
  screenheight = MediaQuery.of(context).size.height;
  orientation = MediaQuery.of(context).orientation;

  defaultSize = orientation == Orientation.landscape
  ? screenheight! * .024
  : screenwidth! * .024;

// ignore: avoid_print
print('this is the default size $defaultSize');
  }
}
const String GOOGLE_MAPS_API_KEY = "AIzaSyBscfN-Reejd7RU7DHcQtycMsN2aZRwHo8";
