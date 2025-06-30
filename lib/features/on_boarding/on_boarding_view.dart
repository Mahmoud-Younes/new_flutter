import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:new_flutter/core/extensions/context_extension.dart';
import 'package:new_flutter/core/routes/app_routes.dart';
import 'package:new_flutter/core/style/app_images.dart';
import 'package:new_flutter/core/style/colors.dart';
import 'package:new_flutter/features/on_boarding/model/on_board_model.dart';
import 'package:new_flutter/start_app/start_page.dart';

class OnBoardingview extends StatefulWidget {
  const OnBoardingview({super.key});

  @override
  State<OnBoardingview> createState() => _OnBoardingviewState();
}

class _OnBoardingviewState extends State<OnBoardingview> {
  @override
  void initState() {

    super.initState();
        // Check login state in initState
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, navigate to StartApp
      Future.microtask(() {
        // context.pushNamedAndRemoveUntil(AppRoutes.startApp);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const StartApp()),
          (route) => false,
        );
      });
    }
  }
    var boardController = PageController();
  bool isLast = false;
    void submit() {
      
    context.pushNamedAndRemoveUntil(AppRoutes.login);
    // CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    //   if (value) {
    //     if (!mounted) return log('OnBoardingViewBody is not mounted');
    //     context.pushNamedAndRemoveUntil(AppRoutes.login);
    //   }
    // });
  }
  List<BoardingModel> boarding = [
    BoardingModel(
      image: AppImages.onBoarding1,
      title: 'Uncover the Magic of Egypt',
      body: 'Ancient wonders, timeless experiences',
    ),
    BoardingModel(
      image: AppImages.onBoarding2,
      title: 'Plan Less, Explore More',
      body: 'Everything you need in one travel companion',
    ),
    BoardingModel(
      image: AppImages.onBoarding3,
      title: 'Welcome to Egypt',
      body: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFEFE),
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder:
                    (context, index) => buildBordingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: AppColors.grey,
                    activeDotColor: AppColors.blue,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   Widget buildBordingItem(BoardingModel board) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image.asset(board.image, fit: BoxFit.fitWidth)),
      SizedBox(height: 20),
      Text(board.title, style: TextStyle(fontSize: 24)),
      SizedBox(height: 15),
      Text(board.body, style: TextStyle(fontSize: 14)),
      SizedBox(height: 15),
    ],
  );
}
