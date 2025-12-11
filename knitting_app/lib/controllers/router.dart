import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_view.dart';
import 'package:knitting_app/views/community_view/community_view.dart';
import 'package:knitting_app/views/feed_view/feed_view.dart';
import 'package:knitting_app/views/profile_view/profile_view.dart';
import 'package:knitting_app/views/search_view/search_view.dart';

// Tüm uygulama geçişleri için tek bir navigator anahtarı oluşturuyoruz.
final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._(); // Bu sınıfın örneği oluşturulmasın diye özel yapıcı fonksiyonumuz, oluşturmaya gerek yok çünkü sabitlerimiz zaten var

  static const String feed = '/'; // static sayesinde nesne oluşturmadan doğruca ileride AppRoutes.search diye erişebiliyoruz
  static const String search = '/search';
  static const String community = '/community';
  static const String profile = '/profile';

  static const String settings = "/settings";
  static const String login = '/login';
}

final router = GoRouter(
  navigatorKey: _routerKey, // uygulamanın herhangi bir yerinden navigatorKey.currentState üzerinden navigator'e erişme imkanı verir
  initialLocation: AppRoutes.feed,

  routes: [_bottomBar()], // bottom bar ile alt barı tek seferde hallediyoruz
);

StatefulShellRoute _bottomBar() {
  // her bir sekme için bir statefulshellbranch yaratıyor ve bunları indexlenmiş stack olarak tutuyor, yani sekmeler aynı anda çalışıyor ama arka planda bekliyor.
  return StatefulShellRoute.indexedStack(
    
    builder: (context, state, navigationShell) =>
        AppView(navigationShell: navigationShell),

    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.feed,
            builder: (context, state) => FeedView(),
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) => const SearchView(),
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.community,
            builder: (context, state) => const CommunityView(),
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
    ],
  );
}
