// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:new_flutter/features/splash/presentation/widgets/splash_body.dart';

class splashview extends StatelessWidget{
  const splashview({super.key,});
  @override
  Widget build(BuildContext context) {
  
    return const Scaffold(
      body: splashViewBody(),
    );
  }

}