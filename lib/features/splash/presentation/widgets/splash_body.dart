
// ignore_for_file: camel_case_types, use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter/core/style/app_images.dart';
import 'package:new_flutter/core/utils/size_config.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/features/on_boarding/on_boarding_view.dart';


class splashViewBody extends StatefulWidget{
    const splashViewBody({Key? key}):super(key: key);
@override
  State<splashViewBody> createState()=>_splashviewbodyState(); 
}

class _splashviewbodyState extends State <splashViewBody>with SingleTickerProviderStateMixin {
   AnimationController? animationController;
    // ignore: non_constant_identifier_names
    Animation? Fadinganimation;
    @override
  void initState() {
    
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    Fadinganimation = Tween<double>(begin: 0.1,end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
    goToNextView();
  }
  @override
  void dispose(){
    animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Sizeconfig().init(context);
    return Scaffold(
      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                ClipRRect(borderRadius: BorderRadius.circular(100),
                                 child: Image.asset(
                fit: BoxFit.cover,AppImages.splash,width:450,height:393)),
                AnimatedBuilder(
                  animation: Fadinganimation!,
                  builder: (context,__)=> Opacity(
                    opacity: Fadinganimation?.value,
                    child: Container(
                      padding: const EdgeInsets.only(top: 90),
                        child: const Text("GoEgypt",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color:kMainColor)
                       )
                      ),
                   ),
                 ), 
              ]           
      )

    );
  }
  void goToNextView() {
    Future.delayed(const Duration(seconds: 3),(){
      Get.to(()=>const OnBoardingview(),transition: Transition.fade);

    });
    }
}

