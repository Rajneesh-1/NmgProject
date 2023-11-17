import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nmg/home/bloc/home_bloc.dart';
import 'package:nmg/home/home_screen.dart';
import 'package:nmg/post_details_comments/bloc/post_details_comments_bloc.dart';
import 'package:nmg/post_details_comments/post_details_comments_screen.dart';
import 'package:nmg/splash_screen/splash_screen.dart';
import 'package:nmg/utility/app_screens.dart';

class AppRoute {
  router(RouteSettings setting) {
    switch (setting.name) {
      case AppScreens.splashScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<HomeBloc>(
                  create: (BuildContext context) => HomeBloc(),
                )
              ],
              child: const SplashScreen(),
            ));

      case AppScreens.homeScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<HomeBloc>(
                      create: (BuildContext context) => HomeBloc(),
                    )
                  ],
                  child: const HomeScreen(),
                ));

      case AppScreens.postDetailsCommentsScreen:
        var args = setting.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<ParticularPostDetailsBloc>(
                  create: (BuildContext context) => ParticularPostDetailsBloc(),
                )
              ],
              child: PostDetailsCommentsScreen(particularPostRelatedData: args),
            ));

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
