import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/scan/presentation/pages/scan_page.dart';
import '../../features/marketplace/presentation/pages/marketplace_page.dart';
import '../../features/education/presentation/pages/education_page.dart';
import '../../features/community/presentation/pages/community_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late List<AnimationController> _iconControllers;

  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.home_rounded,
      activeIcon: Icons.home,
      label: 'Beranda',
      color: WasteWiseTheme.primaryGreen,
    ),
    NavItem(
      icon: Icons.qr_code_scanner_rounded,
      activeIcon: Icons.qr_code_scanner,
      label: 'Scan',
      color: WasteWiseTheme.accentBlue,
    ),
    NavItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: 'Marketplace',
      color: WasteWiseTheme.accentPurple,
    ),
    NavItem(
      icon: Icons.school_outlined,
      activeIcon: Icons.school,
      label: 'Edukasi',
      color: WasteWiseTheme.accentOrange,
    ),
    NavItem(
      icon: Icons.group_outlined,
      activeIcon: Icons.group,
      label: 'Komunitas',
      color: WasteWiseTheme.accentRed,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _iconControllers = List.generate(
      _navItems.length,
      (index) => AnimationController(
        duration: WasteWiseTheme.quickAnimation,
        vsync: this,
      ),
    );
    // Animate the initial selected icon
    _iconControllers[0].forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final controller in _iconControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (index == _currentIndex) return;

    // Animate out current icon
    _iconControllers[_currentIndex].reverse();

    setState(() => _currentIndex = index);

    // Animate in new icon
    _iconControllers[index].forward();

    _pageController.animateToPage(
      index,
      duration: WasteWiseTheme.normalAnimation,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (index != _currentIndex) {
            _onNavItemTapped(index);
          }
        },
        children: [
          const HomePage(),
          const ScanPage(),
          const MarketplacePage(),
          const EducationPage(),
          const CommunityPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 90 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: WasteWiseTheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(WasteWiseTheme.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: WasteWiseTheme.spacing8,
            vertical: WasteWiseTheme.spacing8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (index) {
              return _buildNavItem(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _navItems[index];
    final isSelected = index == _currentIndex;

    return GestureDetector(
          onTap: () => _onNavItemTapped(index),
          child: AnimatedBuilder(
            animation: _iconControllers[index],
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: WasteWiseTheme.spacing12,
                  vertical: WasteWiseTheme.spacing8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with scale animation
                    Transform.scale(
                      scale: 1.0 + (_iconControllers[index].value * 0.2),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? item.color.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isSelected ? item.activeIcon : item.icon,
                          color: isSelected
                              ? item.color
                              : WasteWiseTheme.secondaryText,
                          size: 24,
                        ),
                      ),
                    ),

                    const SizedBox(height: WasteWiseTheme.spacing4),

                    // Label with color animation
                    AnimatedDefaultTextStyle(
                      duration: WasteWiseTheme.quickAnimation,
                      style: WasteWiseTheme.textTheme.labelSmall!.copyWith(
                        color: isSelected
                            ? item.color
                            : WasteWiseTheme.secondaryText,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                      child: Text(item.label),
                    ),

                    // Active indicator
                    AnimatedContainer(
                      duration: WasteWiseTheme.quickAnimation,
                      width: isSelected ? 20 : 0,
                      height: 2,
                      margin: const EdgeInsets.only(
                        top: WasteWiseTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
        .animate(target: isSelected ? 1 : 0)
        .custom(
          duration: WasteWiseTheme.quickAnimation,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, -2 * value),
              child: child,
            );
          },
        );
  }

  Widget _buildComingSoonPage(String title, IconData icon, Color color) {
    return Scaffold(
      backgroundColor: WasteWiseTheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(
                    WasteWiseTheme.radiusXLarge,
                  ),
                ),
                child: Icon(icon, size: 60, color: color),
              ),

              const SizedBox(height: WasteWiseTheme.spacing24),

              Text(
                title,
                style: WasteWiseTheme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: WasteWiseTheme.spacing12),

              Text(
                'Fitur ini sedang dalam pengembangan',
                style: WasteWiseTheme.textTheme.bodyLarge?.copyWith(
                  color: WasteWiseTheme.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: WasteWiseTheme.spacing32),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: WasteWiseTheme.spacing16,
                  vertical: WasteWiseTheme.spacing8,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '🚀 Coming Soon',
                  style: WasteWiseTheme.textTheme.labelMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Color color;

  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.color,
  });
}
