import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nmg/utility/app_color.dart';
import 'package:nmg/utility/app_screens.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin {
  late final AnimationController  _blinker1AnimationController;
  late final Animation<double>    _blinker1Animation;

  late final AnimationController  _blinker2AnimationController;
  late final Animation<double>    _blinker2Animation;

  late final AnimationController  _blinker3AnimationController;
  late final Animation<double>    _blinker3Animation;

  late final AnimationController  _blinker4AnimationController;
  late final Animation<double>    _blinker4Animation;

  late final AnimationController  _blinker5AnimationController;
  late final Animation<double>    _blinker5Animation;

  ValueNotifier<bool> myVariable = ValueNotifier<bool>(false);

  bool isLoading = false;
  BuildContext? splashBlocContext;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _blinker1AnimationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _blinker1Animation = Tween<double>(begin: 1, end: 0)
        .animate(_blinker1AnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _blinker1AnimationController.reset();
        } else if (status == AnimationStatus.dismissed) {
          _blinker2AnimationController.forward();
        }
      });

    _blinker2AnimationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _blinker2Animation = Tween<double>(begin: 1, end: 0)
        .animate(_blinker2AnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _blinker2AnimationController.reset();
        } else if (status == AnimationStatus.dismissed) {
          _blinker3AnimationController.forward();
        }
      });

    _blinker3AnimationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _blinker3Animation = Tween<double>(begin: 1, end: 0)
        .animate(_blinker3AnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _blinker3AnimationController.reset();
        } else if (status == AnimationStatus.dismissed) {
          _blinker4AnimationController.forward();
        }
      });

    _blinker4AnimationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _blinker4Animation = Tween<double>(begin: 1, end: 0)
        .animate(_blinker4AnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _blinker4AnimationController.reset();
        } else if (status == AnimationStatus.dismissed) {
          _blinker5AnimationController.forward();
        }
      });

    _blinker5AnimationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _blinker5Animation = Tween<double>(begin: 1, end: 0)
        .animate(_blinker5AnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _blinker5AnimationController.reset();
        } else if (status == AnimationStatus.dismissed) {
          _blinker1AnimationController.forward();
        }
      });

    Future.delayed(const Duration(seconds: 1), () {
      _blinker1AnimationController.forward();
    });

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, AppScreens.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      border: Border.all(width: 2, color: AppColor.cyan),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset(
                      fit: BoxFit.fill,
                      "assets/images/splash.jpg",
                    ),
                  ),
                  const Text("Developed by Rajneesh", style: TextStyle(color: AppColor.black, fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)).p(16),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                            children: [
                              Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: AppColor.cyan, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                              ).p(8),
                              FadeTransition(
                                opacity: _blinker1Animation,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: AppColor.white, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)]),
                                ).p(8),
                              ),
                            ]
                        ),
                        Stack(
                            children: [
                              Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: AppColor.cyan, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                              ).p(8),
                              FadeTransition(
                                opacity: _blinker2Animation,
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(color: AppColor.white, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                                ).p(8),
                              ),
                            ]
                        ),
                        Stack(
                            children: [
                              Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: AppColor.cyan, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                              ).p(8),
                              FadeTransition(
                                opacity: _blinker3Animation,
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(color: AppColor.white, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                                ).p(8),
                              ),

                            ]
                        ),
                        Stack(
                            children: [
                              Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: AppColor.cyan, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                              ).p(8),
                              FadeTransition(
                                opacity: _blinker4Animation,
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(color: AppColor.white, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                                ).p(8),
                              ),
                            ]
                        ),
                        Stack(
                            children: [
                              Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(color: AppColor.cyan, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                              ).p(8),
                              FadeTransition(
                                opacity: _blinker5Animation,
                                child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(color: AppColor.white, borderRadius: const BorderRadius.all(Radius.circular(20)), border: Border.all(color: AppColor.blue, width: 2), boxShadow: const [BoxShadow(color: AppColor.white, blurRadius: 10.0)])
                                ).p(8),
                              ),
                            ]
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }

  @override
  void dispose() {
    _blinker1AnimationController.dispose();
    _blinker2AnimationController.dispose();
    _blinker3AnimationController.dispose();
    _blinker4AnimationController.dispose();
    _blinker5AnimationController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }
}
