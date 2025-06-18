import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/scan/presentation/pages/scan_page.dart';
import '../../features/marketplace/presentation/pages/marketplace_page.dart';
import '../../features/education/presentation/pages/education_page.dart';
import '../../features/community/presentation/pages/community_page.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/rewards/presentation/pages/rewards_page.dart';
import '../../features/map/presentation/pages/smart_bin_finder_page.dart';
import '../../shared/widgets/main_navigation.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    // Main Navigation Route
    AutoRoute(page: MainNavigationWrapperRoute.page, path: '/', initial: true),

    // Individual Feature Routes
    AutoRoute(page: HomeWrapperRoute.page, path: '/home'),
    AutoRoute(page: ScanWrapperRoute.page, path: '/scan'),
    AutoRoute(page: MarketplaceWrapperRoute.page, path: '/marketplace'),
    AutoRoute(page: EducationWrapperRoute.page, path: '/education'),
    AutoRoute(page: CommunityWrapperRoute.page, path: '/community'),
    AutoRoute(page: AnalyticsWrapperRoute.page, path: '/analytics'),
    AutoRoute(page: NotificationsWrapperRoute.page, path: '/notifications'),
    AutoRoute(page: ProfileWrapperRoute.page, path: '/profile'),
    AutoRoute(page: RewardsWrapperRoute.page, path: '/rewards'),
    AutoRoute(page: SmartBinFinderWrapperRoute.page, path: '/map'),
  ];
}

// Route Pages
@RoutePage()
class MainNavigationWrapperRoute extends StatelessWidget {
  const MainNavigationWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigation();
  }
}

@RoutePage()
class HomeWrapperRoute extends StatelessWidget {
  const HomeWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

@RoutePage()
class ScanWrapperRoute extends StatelessWidget {
  const ScanWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanPage();
  }
}

@RoutePage()
class MarketplaceWrapperRoute extends StatelessWidget {
  const MarketplaceWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const MarketplacePage();
  }
}

@RoutePage()
class EducationWrapperRoute extends StatelessWidget {
  const EducationWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const EducationPage();
  }
}

@RoutePage()
class CommunityWrapperRoute extends StatelessWidget {
  const CommunityWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommunityPage();
  }
}

@RoutePage()
class AnalyticsWrapperRoute extends StatelessWidget {
  const AnalyticsWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnalyticsPage();
  }
}

@RoutePage()
class NotificationsWrapperRoute extends StatelessWidget {
  const NotificationsWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotificationsPage();
  }
}

@RoutePage()
class ProfileWrapperRoute extends StatelessWidget {
  const ProfileWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

@RoutePage()
class RewardsWrapperRoute extends StatelessWidget {
  const RewardsWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const RewardsPage();
  }
}

@RoutePage()
class SmartBinFinderWrapperRoute extends StatelessWidget {
  const SmartBinFinderWrapperRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const SmartBinFinderPage();
  }
}
