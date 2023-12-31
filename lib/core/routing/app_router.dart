import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/features/Liked%20Songs/presentation/liked_songs_screen.dart';
import 'package:flutez/features/Profile/presentation/profile_screen.dart';
import 'package:flutez/features/Search/Bloc/search_cubit.dart';
import 'package:flutez/features/Search/presentation/search_screen.dart';
import 'package:flutez/features/Track/presentation/playing_now_screen.dart';
import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      // case Routes.loginScreen:
      //   return PageTransition(
      //     child: LoginScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.registerScreen:
      //   return PageTransition(
      //     child: RegisterScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.mainLayoutScreen:
      //   return PageTransition(
      //     child: BlocProvider(
      //       create: (context) => MainLayoutCubit(),
      //       child: const MainLayoutScreen(),
      //     ),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.onBoarding:
      //   return PageTransition(
      //     child: BlocProvider(
      //         create: (context) => OnBoardingCubit(),
      //         child: const OnBoardingScreen()),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      case Routes.homeScreen:
        return PageTransition(
          child: BlocProvider(
            child: const HomeScreen(),
            create: (context) => HomeCubit()..getRecommendedTracks(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.likedSongs:
        return PageTransition(
          child: const LikedSongsScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.playingNowScreen:
        return PageTransition(
          child: const PlayingNowScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.profile:
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.searchScreen:
        return PageTransition(
          child: BlocProvider(
              create: (BuildContext context) => SearchCubit(),
              child: SearchScreen()),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      // case Routes.notificationsScreen:
      //   return PageTransition(
      //     child: const NotificationsScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.editProfile:
      //   return PageTransition(
      //     child: EditProfileScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.bookRoom:
      //   return PageTransition(
      //     child: BlocProvider(
      //       create: (context) => BookCubit(),
      //       child: BookRoomScreen(),
      //     ),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      default:
        return PageTransition(
          child: Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
        );
    }
  }

  // List<Widget> screens = [
  //   BlocProvider(
  //     create: (context) => HomeCubit(),
  //     child: HomeScreen(),
  //   ),
  //   CurrentSurgeriesScreen(),
  //   PastSurgeriesScreen(),
  //   const ProfileScreen(),
  // ];
}
