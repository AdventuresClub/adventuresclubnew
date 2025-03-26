import 'package:app/app_link_page.dart';
import 'package:app/check_profile.dart';
import 'package:app/choose_language.dart';
import 'package:app/home_Screens/accounts/about.dart';
import 'package:app/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:app/home_Screens/navigation_screens/home.dart';
import 'package:app/home_Screens/new_details.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/sign_up/sign_in.dart';
import 'package:app/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final webRootNavigatorKey = GlobalKey<NavigatorState>();
final webShellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    );
  },
  redirect: (context, state) {
    if (state.uri.path.contains('/appLinkPage')) {
      return '/appLinkPage/${state.uri.queryParameters['id']}/${state.uri.queryParameters['sID']}';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/appLinkPage/:id/:sID',
      builder: (BuildContext context, GoRouterState state) {
        String? id = state.pathParameters['id'];
        int? sId;
        if (state.pathParameters['sID'] != null) {
          sId = int.tryParse(state.pathParameters['sID']!);
        }
        return AppLinkPage(id: id, sId: sId);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/about',
      builder: (BuildContext context, GoRouterState state) {
        dynamic extra = state.extra;
        String? id;
        int? sID;
        if (extra != null && extra['id'] != null) {
          id = extra['id'];
        }
        if (extra != null && extra['sID'] != null) {
          sID = extra['sID'];
        }
        return About(id: id, sId: sID);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/checkProfile',
      builder: (BuildContext context, GoRouterState state) {
        return CheckProfile();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/chooseLanguage',
      builder: (BuildContext context, GoRouterState state) {
        return ChooseLanguage();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/signIn',
      builder: (BuildContext context, GoRouterState state) {
        return SignIn();
      },
    ),
    //https://adventuresclub.net/newDetails/6
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/newDetails',
      builder: (BuildContext context, GoRouterState state) {
        String? id = state.pathParameters['id'];
        dynamic extra = state.extra;
        ServicesModel? gm;
        bool? show;
        if (extra != null && extra['gm'] != null) {
          gm = extra['gm'];
        }
        if (extra != null && extra['show'] != null) {
          show = extra['show'];
        }
        return NewDetails(
          gm: gm,
          show: show,
          id: id,
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/aDetails/:id',
      builder: (BuildContext context, GoRouterState state) {
        String? id = state.pathParameters['id'];
        dynamic extra = state.extra;
        ServicesModel? gm;
        bool? show;
        if (extra != null && extra['gm'] != null) {
          gm = extra['gm'];
        }
        if (extra != null && extra['show'] != null) {
          show = extra['show'];
        }
        return NewDetails(
          gm: gm,
          show: show,
          id: id,
        );
      },
    ),

    /* GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        dynamic extra = state.extra;
        PublicProfileModel? profile;
        List<String>? selectedIdentificationLists;
        List<CategoriesDataModel>? selectedInterests;
        String? mode;
        if (extra != null && extra['profileModel'] != null) {
          profile = extra['profileModel'];
        }
        if (extra != null && extra['identificationList'] != null) {
          selectedIdentificationLists = extra['identificationList'];
        }
        if (extra != null && extra['selectedInterest'] != null) {
          selectedInterests = extra['selectedInterest'];
        }
        if (extra != null && extra['mode'] != null) {
          mode = extra['mode'];
        }
        return CreateProfile(
            mode, profile, selectedIdentificationLists, selectedInterests);
      },
    ),
    GoRoute(
        path: "/addMediaLinks",
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          dynamic extra = state.extra!;
          return AddSocialMediaLinks(extra);
        }),*/
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => BottomNavigation(child: child),
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: shellNavigatorKey,
          builder: (context, state) => const Home(),
        ),
        // GoRoute(
        //   path: '/adminUsers',
        //   parentNavigatorKey: shellNavigatorKey,
        //   builder: (context, state) => const AdminUsers(),
        // ),
        // GoRoute(
        //   path: '/approvalAndReject',
        //   parentNavigatorKey: shellNavigatorKey,
        //   builder: (context, state) => const ApprovalAndReject(),
        // ),
        // GoRoute(
        //   path: '/wallets',
        //   parentNavigatorKey: shellNavigatorKey,
        //   builder: (context, state) => const AllWallets(),
        // ),
      ],
    ),
  ],
);
