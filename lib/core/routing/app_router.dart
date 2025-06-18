import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/scan/presentation/pages/scan_page.dart';
import '../../features/marketplace/presentation/pages/marketplace_page.dart';
import '../../features/education/presentation/pages/education_page.dart';
import '../../features/community/presentation/pages/community_page.dart';
import '../../shared/widgets/main_navigation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Main Navigation Route
    AutoRoute(page: MainNavigationRoute.page, path: '/', initial: true),

    // Individual Feature Routes
    AutoRoute(page: HomeRoute.page, path: '/home'),

    AutoRoute(page: ScanRoute.page, path: '/scan'),

    AutoRoute(page: MarketplaceRoute.page, path: '/marketplace'),

    AutoRoute(page: EducationRoute.page, path: '/education'),

    AutoRoute(page: CommunityRoute.page, path: '/community'),
  ];
}

// Route Pages
@RoutePage()
class MainNavigationRoute extends StatelessWidget {
  const MainNavigationRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigation();
  }
}

@RoutePage()
class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

@RoutePage()
class ScanRoute extends StatelessWidget {
  const ScanRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanPage();
  }
}

@RoutePage()
class MarketplaceRoute extends StatelessWidget {
  const MarketplaceRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const MarketplacePage();
  }
}

@RoutePage()
class EducationRoute extends StatelessWidget {
  const EducationRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const EducationPage();
  }
}

@RoutePage()
class CommunityRoute extends StatelessWidget {
  const CommunityRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommunityPage();
  }
}
