import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/map/presentation/pages/smart_bin_finder_page.dart';
import '../../features/scan/presentation/pages/scan_page.dart';
import '../../features/marketplace/presentation/pages/marketplace_page.dart';
import '../../features/education/presentation/pages/education_page.dart';
import '../../features/community/presentation/pages/community_page.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomBottomNavigation({super.key, this.currentIndex = 0, this.onTap});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation>
    with TickerProviderStateMixin {
  late List<AnimationController> _iconControllers;

  // Same color palette as home_page.dart for consistency
  static const Color _backgroundColor = Color(0xFFF8FAFC);
  static const Color _primaryGreen = Color(0xFF10B981);
  static const Color _recycleBlue = Color(0xFF0EA5E9);
  static const Color _rewardPurple = Color(0xFF8B5CF6);
  static const Color _hazardOrange = Color(0xFFF59E0B);
  static const Color _statCoral = Color(0xFFEF4444);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _surfaceWhite = Color(0xFFFFFFFF);

  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.home_rounded,
      activeIcon: Icons.home,
      label: 'Home',
      color: _primaryGreen,
    ),
    NavItem(
      icon: Icons.location_on_outlined,
      activeIcon: Icons.location_on,
      label: 'Smart Bin',
      color: _recycleBlue,
    ),
    NavItem(
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: 'Marketplace',
      color: _hazardOrange,
    ),
    NavItem(
      icon: Icons.school_outlined,
      activeIcon: Icons.school,
      label: 'Education',
      color: _statCoral,
    ),
    NavItem(
      icon: Icons.group_outlined,
      activeIcon: Icons.group,
      label: 'Community',
      color: _primaryGreen,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _iconControllers = List.generate(
      _navItems.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      ),
    );
    // Animate the initial selected icon
    _iconControllers[widget.currentIndex].forward();
  }

  @override
  void dispose() {
    for (final controller in _iconControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    if (index == widget.currentIndex) return;

    HapticFeedback.lightImpact();

    // Animate out current icon
    _iconControllers[widget.currentIndex].reverse();

    // Animate in new icon
    _iconControllers[index].forward();

    // Navigate to the appropriate page
    _navigateToPage(index);

    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }

  void _navigateToPage(int index) {
    Widget targetPage;

    switch (index) {
      case 0:
        targetPage = const HomePage();
        break;
      case 1:
        targetPage = const SmartBinFinderPage();
        break;
      case 2:
        targetPage = const MarketplacePage();
        break;
      case 3:
        targetPage = const EducationPage();
        break;
      case 4:
        targetPage = const CommunityPage();
        break;
      default:
        return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetPage,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: _surfaceWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
    final isSelected = index == widget.currentIndex;

    return GestureDetector(
          onTap: () => _onNavItemTapped(index),
          child: AnimatedBuilder(
            animation: _iconControllers[index],
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with scale animation
                    Transform.scale(
                      scale: 1.0 + (_iconControllers[index].value * 0.15),
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
                          color: isSelected ? item.color : _textSecondary,
                          size: 22,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Label with color animation
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected ? item.color : _textSecondary,
                      ),
                      child: Text(item.label),
                    ),

                    // Active indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isSelected ? 16 : 0,
                      height: 2,
                      margin: const EdgeInsets.only(top: 2),
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
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, -2 * value),
              child: child,
            );
          },
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
