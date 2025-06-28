import 'package:flutter/material.dart';
import 'package:new_flutter/core/utils/size_config.dart';

class Horizintalspace extends StatelessWidget { const Horizintalspace(this.value, {super.key});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizeconfig.defaultSize!*value!,
    );
  }
}
class Verticalspace extends StatelessWidget {
  const Verticalspace(this.value, {super.key});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizeconfig.defaultSize!*value!,
    );
  }
}
