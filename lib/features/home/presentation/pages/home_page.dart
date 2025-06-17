import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as inset;
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/gamified_button.dart';
import 'package:wastewise/shared/widgets/points_badge.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _floatingController;
  late PageController _pageController;

  int _currentPage = 0;

  // Modern Soft-3D Neumorphic Color Palette
  static const Color _backgroundColor = Color(0xFFF0F2F5);
  static const Color _cardBackground = Color(0xFFF0F2F5);
  static const Color _primaryGreen = Color(0xFF52C41A);
  static const Color _lightGreen = Color(0xFFF6FFED);
  static const Color _textPrimary = Color(0xFF262626);
  static const Color _textSecondary = Color(0xFF8C8C8C);
  static const Color _shadowLight = Color(0xFFFFFFFF);
  static const Color _shadowDark = Color(0xFFD9D9D9);

  // Pastel Colors for Categories
  static const Color _mintGreen = Color(0xFF87E8DE);
  static const Color _skyBlue = Color(0xFF91D5FF);
  static const Color _amber = Color(0xFFFFD666);
  static const Color _coolGrey = Color(0xFFBFBFBF);
  static const Color _coral = Color(0xFFFF9C6E);
  static const Color _lavender = Color(0xFFB37FEB);

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _pageController = PageController();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _floatingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          // Soft Decorative Elements
          _buildSoftDecorations(),

          // Main Content
          SafeArea(
            child: FadeIn(
              duration: const Duration(milliseconds: 600),
              child: CustomScrollView(
                slivers: [
                  // Neumorphic Header
                  SliverToBoxAdapter(child: _buildNeumorphicHeader()),

                  // Soft Points Panel
                  SliverToBoxAdapter(child: _buildSoftPointsPanel()),

                  // Today's Impact with Pastel Colors
                  SliverToBoxAdapter(child: _buildPastelTodaysImpact()),

                  // Soft 3D Quick Actions
                  SliverToBoxAdapter(child: _buildSoft3DQuickActions()),

                  // Elevated Achievements
                  SliverToBoxAdapter(child: _buildElevatedAchievements()),

                  const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftDecorations() {
    return Stack(
      children: [
        // Subtle floating leaf decoration
        Positioned(
          top: 80,
          right: 20,
          child: AnimatedBuilder(
            animation: _floatingController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  math.sin(_floatingController.value * 2 * math.pi) * 8,
                  math.cos(_floatingController.value * 2 * math.pi) * 12,
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _lightGreen,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      inset.BoxShadow(
                        color: _shadowDark.withOpacity(0.3),
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                      ),
                      inset.BoxShadow(
                        color: _shadowLight,
                        offset: const Offset(-4, -4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      LucideIcons.leaf,
                      color: _primaryGreen,
                      size: 24,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNeumorphicHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: FadeInDown(
        duration: const Duration(milliseconds: 600),
        child: Row(
          children: [
            // Neumorphic Avatar
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_pulseController.value * 0.03),
                  child: ClayContainer(
                    width: 60,
                    height: 60,
                    depth: 20,
                    borderRadius: 30,
                    color: _cardBackground,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            _primaryGreen.withOpacity(0.8),
                            _primaryGreen,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        LucideIcons.user,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(width: 20),

            // Enhanced Greeting
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang, Kairos',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mari buat dampak positif hari ini 🌱',
                    style: TextStyle(
                      fontSize: 15,
                      color: _textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Soft Notification
            ClayContainer(
              width: 50,
              height: 50,
              depth: 15,
              borderRadius: 25,
              color: _cardBackground,
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      LucideIcons.bell,
                      color: _textSecondary,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _coral,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: _coral.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoftPointsPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: FadeInUp(
        duration: const Duration(milliseconds: 700),
        child: ClayContainer(
          depth: 30,
          borderRadius: 28,
          color: _cardBackground,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  _primaryGreen.withOpacity(0.1),
                  _lightGreen.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Poin Anda',
                          style: TextStyle(
                            fontSize: 16,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TweenAnimationBuilder<int>(
                          tween: IntTween(begin: 0, end: 16500),
                          duration: const Duration(milliseconds: 2000),
                          builder: (context, value, child) {
                            return Text(
                              '$value',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: _textPrimary,
                                height: 1.1,
                              ),
                            );
                          },
                        ),
                        Text(
                          'Poin',
                          style: TextStyle(
                            fontSize: 18,
                            color: _textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // Soft Exchange Button
                    ClayContainer(
                      depth: 15,
                      borderRadius: 20,
                      color: _cardBackground,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.arrowRightLeft,
                              color: _primaryGreen,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Tukar Poin',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Level Progress with Soft Design
                Row(
                  children: [
                    ClayContainer(
                      depth: 10,
                      borderRadius: 16,
                      color: _cardBackground,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          'Level 4',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _primaryGreen,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Eco Warrior',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: _textPrimary,
                                ),
                              ),
                              Text(
                                '80%',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _primaryGreen,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClayContainer(
                            height: 8,
                            depth: 5,
                            borderRadius: 4,
                            color: _cardBackground,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 0.8),
                              duration: const Duration(milliseconds: 1500),
                              builder: (context, value, child) {
                                return FractionallySizedBox(
                                  widthFactor: value,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      gradient: LinearGradient(
                                        colors: [_primaryGreen, _mintGreen],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPastelTodaysImpact() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Dampak Hari Ini',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Pastel Waste Types Grid
          FadeInUp(
            duration: const Duration(milliseconds: 900),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildPastelWasteCard(
                  'Organik',
                  '2.4',
                  'kg',
                  LucideIcons.leaf,
                  _mintGreen,
                ),
                _buildPastelWasteCard(
                  'Anorganik',
                  '3.6',
                  'kg',
                  LucideIcons.recycle,
                  _skyBlue,
                ),
                _buildPastelWasteCard(
                  'B3',
                  '0.2',
                  'kg',
                  LucideIcons.alertTriangle,
                  _amber,
                ),
                _buildPastelWasteCard(
                  'Residu',
                  '0.8',
                  'kg',
                  LucideIcons.trash2,
                  _coolGrey,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Soft Statistics
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: Row(
              children: [
                Expanded(
                  child: _buildSoftStatCard(
                    'Item Didaur',
                    '12',
                    LucideIcons.package,
                    _coral,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSoftStatCard(
                    'Poin Hari Ini',
                    '340',
                    LucideIcons.star,
                    _lavender,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastelWasteCard(
    String type,
    String amount,
    String unit,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => HapticFeedback.selectionClick(),
      child: ClayContainer(
        depth: 20,
        borderRadius: 24,
        color: _cardBackground,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClayContainer(
                width: 56,
                height: 56,
                depth: 15,
                borderRadius: 28,
                color: color.withOpacity(0.2),
                child: Icon(icon, color: color.withOpacity(0.8), size: 28),
              ),
              const SizedBox(height: 16),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: double.parse(amount)),
                duration: const Duration(milliseconds: 1200),
                builder: (context, value, child) {
                  return Text(
                    '${value.toStringAsFixed(1)} $unit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _textPrimary,
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              Text(
                type,
                style: TextStyle(
                  fontSize: 14,
                  color: _textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSoftStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return ClayContainer(
      depth: 20,
      borderRadius: 20,
      color: _cardBackground,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ClayContainer(
              width: 48,
              height: 48,
              depth: 12,
              borderRadius: 24,
              color: color.withOpacity(0.2),
              child: Icon(icon, color: color.withOpacity(0.8), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: int.parse(value)),
                    duration: const Duration(milliseconds: 1000),
                    builder: (context, animatedValue, child) {
                      return Text(
                        '$animatedValue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: _textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoft3DQuickActions() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 1100),
            child: Text(
              'Aksi Cepat',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),

          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildSoft3DActionCard(
                  'Scan Now',
                  LucideIcons.camera,
                  _primaryGreen,
                  0,
                ),
                _buildSoft3DActionCard(
                  'Find Smart Bin',
                  LucideIcons.mapPin,
                  _skyBlue,
                  1,
                ),
                _buildSoft3DActionCard(
                  'Track Recycle',
                  LucideIcons.barChart3,
                  _lavender,
                  2,
                ),
                _buildSoft3DActionCard(
                  'Earn Rewards',
                  LucideIcons.gift,
                  _coral,
                  3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoft3DActionCard(
    String title,
    IconData icon,
    Color color,
    int index,
  ) {
    return SlideInUp(
      delay: Duration(milliseconds: 100 * index),
      duration: const Duration(milliseconds: 600),
      child: GestureDetector(
        onTap: () => HapticFeedback.mediumImpact(),
        child: ClayContainer(
          depth: 25,
          borderRadius: 24,
          color: _cardBackground,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClayContainer(
                  width: 64,
                  height: 64,
                  depth: 20,
                  borderRadius: 32,
                  color: color.withOpacity(0.3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: LinearGradient(
                        colors: [color.withOpacity(0.8), color],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(icon, color: Colors.white, size: 30),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedAchievements() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 1300),
            child: Text(
              'Pencapaian Terbaru',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),

          ...List.generate(3, (index) {
            final achievements = [
              {
                'title': 'Eco Pioneer',
                'desc': '100+ items didaur ulang',
                'color': _mintGreen,
                'icon': LucideIcons.leaf,
                'tag': 'BARU',
                'tagColor': _primaryGreen,
              },
              {
                'title': 'Point Master',
                'desc': '10.000 poin terkumpul',
                'color': _amber,
                'icon': LucideIcons.star,
                'tag': 'SELESAI',
                'tagColor': _coral,
              },
              {
                'title': 'Community Hero',
                'desc': '50+ orang terbantu',
                'color': _skyBlue,
                'icon': LucideIcons.users,
                'tag': null,
                'tagColor': null,
              },
            ];

            final achievement = achievements[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SlideInRight(
                delay: Duration(milliseconds: 200 * index),
                duration: const Duration(milliseconds: 600),
                child: ClayContainer(
                  depth: 20,
                  borderRadius: 24,
                  color: _cardBackground,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        ClayContainer(
                          width: 64,
                          height: 64,
                          depth: 15,
                          borderRadius: 32,
                          color: (achievement['color'] as Color).withOpacity(
                            0.3,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              gradient: LinearGradient(
                                colors: [
                                  (achievement['color'] as Color).withOpacity(
                                    0.8,
                                  ),
                                  achievement['color'] as Color,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Icon(
                              achievement['icon'] as IconData,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    achievement['title'] as String,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  if (achievement['tag'] != null) ...[
                                    const SizedBox(width: 12),
                                    ClayContainer(
                                      depth: 8,
                                      borderRadius: 12,
                                      color: (achievement['tagColor'] as Color)
                                          .withOpacity(0.2),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          achievement['tag'] as String,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                achievement['tagColor']
                                                    as Color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                achievement['desc'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClayContainer(
                          width: 36,
                          height: 36,
                          depth: 10,
                          borderRadius: 18,
                          color: _cardBackground,
                          child: const Icon(
                            LucideIcons.chevronRight,
                            color: _textSecondary,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
