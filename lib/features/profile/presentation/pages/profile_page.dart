import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/gamified_button.dart';
import 'package:wastewise/shared/widgets/custom_bottom_navigation.dart';
import 'package:wastewise/features/scan/presentation/pages/scan_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;

  // Using same color palette as home_page.dart
  static const Color _backgroundColor = Color(0xFFF8FAFC);
  static const Color _primaryGreen = Color(0xFF10B981);
  static const Color _lightGreen = Color(0xFFECFDF5);
  static const Color _textPrimary = Color(0xFF1F2937);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _surfaceWhite = Color(0xFFFFFFFF);
  static const Color _recycleBlue = Color(0xFF0EA5E9);
  static const Color _hazardOrange = Color(0xFFF59E0B);
  static const Color _rewardPurple = Color(0xFF8B5CF6);
  static const Color _statCoral = Color(0xFFEF4444);

  // Same typography system
  static const TextStyle _headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: _textPrimary,
  );

  static const TextStyle _subheadingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _textPrimary,
  );

  static const TextStyle _captionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: _textSecondary,
  );

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: FadeIn(
          duration: const Duration(milliseconds: 600),
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildProfileHeader(),
                      const SizedBox(height: 24),
                      _buildStatsGrid(),
                      const SizedBox(height: 24),
                      _buildMenuItems(),
                      const SizedBox(
                        height: 100,
                      ), // Extra padding for bottom navigation
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanPage()),
          );
        },
        backgroundColor: _rewardPurple,
        child: const Icon(LucideIcons.qrCode, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _surfaceWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                LucideIcons.arrowLeft,
                color: _textPrimary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(child: Text('My Profile', style: _headingStyle)),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              // TODO: Navigate to settings
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _surfaceWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                LucideIcons.settings,
                color: _textPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: GlassCard(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_primaryGreen, _primaryGreen.withOpacity(0.8)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _primaryGreen.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    LucideIcons.user,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      // TODO: Image picker
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _recycleBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        LucideIcons.camera,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Kairos Fukami',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Eco Warrior • Level 4',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Passionate about environmental sustainability and waste reduction. Let\'s make our planet cleaner together! 🌱',
              style: _captionStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Points',
                '16,500',
                LucideIcons.star,
                _rewardPurple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Items Recycled',
                '142',
                LucideIcons.recycle,
                _recycleBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'CO₂ Saved',
                '28.5 kg',
                LucideIcons.leaf,
                _primaryGreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'Streak Days',
                '45',
                LucideIcons.flame,
                _hazardOrange,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        // TODO: Show detailed stats
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      {
        'title': 'Edit Profile',
        'icon': LucideIcons.edit3,
        'color': _primaryGreen,
        'onTap': () {
          // TODO: Navigate to edit profile
        },
      },
      {
        'title': 'My Achievements',
        'icon': LucideIcons.award,
        'color': _hazardOrange,
        'onTap': () {
          // TODO: Navigate to achievements
        },
      },
      {
        'title': 'Recycling History',
        'icon': LucideIcons.history,
        'color': _recycleBlue,
        'onTap': () {
          // TODO: Navigate to history
        },
      },
      {
        'title': 'Privacy Settings',
        'icon': LucideIcons.shield,
        'color': _rewardPurple,
        'onTap': () {
          // TODO: Navigate to privacy settings
        },
      },
      {
        'title': 'Help & Support',
        'icon': LucideIcons.helpCircle,
        'color': _textSecondary,
        'onTap': () {
          // TODO: Navigate to help
        },
      },
      {
        'title': 'Sign Out',
        'icon': LucideIcons.logOut,
        'color': _statCoral,
        'onTap': () {
          // TODO: Show sign out dialog
        },
      },
    ];

    return Column(
      children: menuItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return FadeInLeft(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              onTap: () {
                HapticFeedback.lightImpact();
                (item['onTap'] as VoidCallback)();
              },
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: _subheadingStyle,
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    color: _textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
