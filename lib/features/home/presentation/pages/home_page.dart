import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/gamified_button.dart';
import 'package:wastewise/shared/widgets/points_badge.dart';

/// WasteWise HomePage - Refactored v7.0
/// Fixed spacing issues, optimized layout structure, clean architecture
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;

  // Enhanced Color Palette
  static const Color _backgroundColor = Color(0xFFF8FAFC);
  static const Color _primaryGreen = Color(0xFF10B981);
  static const Color _lightGreen = Color(0xFFECFDF5);
  static const Color _textPrimary = Color(0xFF1F2937);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _surfaceWhite = Color(0xFFFFFFFF);

  // Vibrant Category Colors
  static const Color _organicGreen = Color(0xFF059669);
  static const Color _recycleBlue = Color(0xFF0EA5E9);
  static const Color _hazardOrange = Color(0xFFF59E0B);
  static const Color _residueGray = Color(0xFF6B7280);
  static const Color _rewardPurple = Color(0xFF8B5CF6);
  static const Color _statCoral = Color(0xFFEF4444);

  // Typography System
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

  static const TextStyle _unitStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: _textSecondary,
  );

  @override
  void initState() {
    super.initState();

    debugPrint('🎨 WasteWise HomePage v7.0 - Refactored & Spacing Fixed');

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height, // Ensure full screen height
        child: Stack(
          children: [
            _buildScrollableContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return FadeIn(
      duration: const Duration(milliseconds: 600),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Points Panel
            _buildHeaderSection(),

            // Main Content Sections
            _buildMainContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 356,
      child: Stack(
        children: [
          // Green Gradient Background
          Container(
            height: 165,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _primaryGreen,
                  _primaryGreen.withOpacity(0.9),
                  _primaryGreen.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  16,
                ), // Reduced top padding for better notch alignment
                child: _buildHeader(),
              ),
            ),
          ),

          // Curved Points Panel
          Positioned(bottom: 0, left: 0, right: 0, child: _buildPointsPanel()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar/Profile Icon
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.03),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    LucideIcons.user,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              );
            },
          ),

          const SizedBox(width: 16),

          // Greeting Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome, Kairos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Let\'s make a positive impact today',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Notification Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(LucideIcons.bell, color: Colors.white, size: 22),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _statCoral,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsPanel() {
    return FadeInUp(
      duration: const Duration(milliseconds: 700),
      child: Container(
        height: 220,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 240),
              painter: CurvedTopPainter(),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 12),
                child: Column(
                  children: [
                    // Points Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Total Points', style: _captionStyle),
                            const SizedBox(height: 4),
                            TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: 16500),
                              duration: const Duration(milliseconds: 1500),
                              builder: (context, value, child) {
                                return Text(
                                  '$value',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: _textPrimary,
                                    height: 1.1,
                                  ),
                                );
                              },
                            ),
                            Text('Points', style: _unitStyle),
                          ],
                        ),

                        // Exchange Button
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _primaryGreen,
                                _primaryGreen.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: _primaryGreen.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.arrowRightLeft,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Exchange Points',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Level Progress
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _lightGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _primaryGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Level 4',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Eco Warrior',
                                      style: _captionStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _textPrimary,
                                      ),
                                    ),
                                    Text(
                                      '80%',
                                      style: _unitStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _primaryGreen,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                LinearProgressIndicator(
                                  value: 0.8,
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation(
                                    _primaryGreen,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's Impact Section
          _buildSection(title: 'Today\'s Impact', child: _buildWasteCards()),

          const SizedBox(height: 24),

          // Statistics Section
          _buildSection(title: 'Statistics', child: _buildStatisticsRow()),

          const SizedBox(height: 24),

          // Quick Actions Section
          _buildSection(
            title: 'Quick Actions',
            child: _buildQuickActionCards(),
          ),

          const SizedBox(height: 24),

          // Achievements Section
          _buildSection(title: 'Achievements', child: _buildAchievementsList()),

          const SizedBox(
            height: 20,
          ), // Reduced bottom spacing since we have proper navigation
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: _headingStyle),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  // Fixed Waste Cards Layout - No more GridView spacing issues
  Widget _buildWasteCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _WasteCard(
                'Organic',
                '2.4',
                'kg',
                LucideIcons.leaf,
                _organicGreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _WasteCard(
                'Recyclable',
                '3.6',
                'kg',
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
              child: _WasteCard(
                'Hazardous',
                '0.2',
                'kg',
                LucideIcons.alertTriangle,
                _hazardOrange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _WasteCard(
                'Residual',
                '0.8',
                'kg',
                LucideIcons.trash2,
                _residueGray,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _WasteCard(
    String type,
    String amount,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Container(
      height: 70, // Fixed height to prevent spacing issues
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$amount $unit',
                  style: _subheadingStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                ),
                Text(
                  type,
                  style: _unitStyle.copyWith(fontSize: 12),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            'Items Recycled',
            '12',
            LucideIcons.package,
            _rewardPurple,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            'Today\'s Points',
            '340',
            LucideIcons.star,
            _statCoral,
          ),
        ),
      ],
    );
  }

  Widget _StatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fixed Quick Action Cards Layout - No more GridView spacing issues
  Widget _buildQuickActionCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                'Scan Now',
                LucideIcons.camera,
                _primaryGreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                'Find Smart Bin',
                LucideIcons.mapPin,
                _recycleBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                'Track Recycle',
                LucideIcons.barChart3,
                _rewardPurple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickActionCard(
                'Earn Rewards',
                LucideIcons.gift,
                _hazardOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _QuickActionCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => HapticFeedback.mediumImpact(),
      child: Container(
        height: 90, // Fixed height to prevent spacing issues
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _surfaceWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36, // Reduced size for better proportion
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.8)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: _captionStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: _textPrimary,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsList() {
    final achievements = [
      {
        'title': 'Eco Pioneer',
        'desc': '100+ items recycled',
        'color': _organicGreen,
        'icon': LucideIcons.leaf,
        'tag': 'NEW',
        'tagColor': _primaryGreen,
      },
      {
        'title': 'Point Master',
        'desc': '10,000 points collected',
        'color': _hazardOrange,
        'icon': LucideIcons.star,
        'tag': 'COMPLETED',
        'tagColor': _statCoral,
      },
      {
        'title': 'Community Hero',
        'desc': '50+ people helped',
        'color': _recycleBlue,
        'icon': LucideIcons.users,
        'tag': null,
        'tagColor': null,
      },
    ];

    return Column(
      children: achievements
          .map(
            (achievement) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _AchievementItem(achievement),
            ),
          )
          .toList(),
    );
  }

  Widget _AchievementItem(Map<String, dynamic> achievement) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  achievement['color'] as Color,
                  (achievement['color'] as Color).withOpacity(0.8),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              achievement['icon'] as IconData,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      achievement['title'] as String,
                      style: _subheadingStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (achievement['tag'] != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (achievement['tagColor'] as Color).withOpacity(
                            0.1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          achievement['tag'] as String,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: achievement['tagColor'] as Color,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(achievement['desc'] as String, style: _captionStyle),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, color: _textSecondary, size: 16),
        ],
      ),
    );
  }
}

// Custom Painter for Curved Top
class CurvedTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 30);
    path.quadraticBezierTo(
      size.width * 0.25, 15,
      size.width * 0.5, 15,
    );
    path.quadraticBezierTo(
      size.width * 0.75, 15,
      size.width, 30,
    );


    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawPath(path, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
