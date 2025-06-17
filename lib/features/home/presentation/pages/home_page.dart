import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
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
  late AnimationController _particleController;
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _breathingController;
  late PageController _pageController;

  int _currentPage = 0;
  bool _showParticles = true;
  double _scrollOffset = 0.0;

  final List<Color> _gradientColors = [
    const Color(0xFF4CAF50),
    const Color(0xFF81C784),
    const Color(0xFF66BB6A),
    const Color(0xFF8BC34A),
  ];

  final List<WasteCategory> _wasteData = [
    WasteCategory(
      name: 'Organik',
      weight: 4.2,
      icon: Icons.eco,
      color: WasteWiseTheme.primaryGreen,
      unit: 'kg',
    ),
    WasteCategory(
      name: 'Anorganik',
      weight: 5.7,
      icon: Icons.recycling,
      color: WasteWiseTheme.accentBlue,
      unit: 'kg',
    ),
    WasteCategory(
      name: 'B3',
      weight: 0.3,
      icon: Icons.warning,
      color: WasteWiseTheme.accentOrange,
      unit: 'kg',
    ),
    WasteCategory(
      name: 'Residu',
      weight: 1.1,
      icon: Icons.delete,
      color: WasteWiseTheme.accentRed,
      unit: 'kg',
    ),
  ];

  final List<QuickAction> _quickActions = [
    QuickAction(
      title: 'AI Scan Sampah',
      subtitle: 'Klasifikasi otomatis dengan kamera',
      icon: Icons.camera_alt,
      color: WasteWiseTheme.primaryGreen,
      route: '/scan',
    ),
    QuickAction(
      title: 'Smart Bin',
      subtitle: 'Cek lokasi & status tempat sampah pintar',
      icon: Icons.location_on,
      color: WasteWiseTheme.accentBlue,
      route: '/smartbin',
    ),
    QuickAction(
      title: 'Marketplace',
      subtitle: 'Tukar poin dengan produk ramah lingkungan',
      icon: Icons.shopping_bag,
      color: WasteWiseTheme.accentPurple,
      route: '/marketplace',
    ),
    QuickAction(
      title: 'Belajar',
      subtitle: 'Pelajari cara memilah dan daur ulang',
      icon: Icons.school,
      color: WasteWiseTheme.accentOrange,
      route: '/education',
    ),
    QuickAction(
      title: 'Event',
      subtitle: 'Tantangan komunitas untuk kumpulkan poin',
      icon: Icons.emoji_events,
      color: WasteWiseTheme.goldStar,
      route: '/community',
    ),
  ];

  final List<String> _articleTabs = ['Artikel', 'Video', 'Quiz'];

  final List<Article> _articles = [
    Article(
      title: 'DaurUang: Solusi Tukar Sampah',
      date: '24 Nov 2024',
      badge: 'Baru',
      badgeColor: WasteWiseTheme.primaryGreen,
      imageUrl: 'assets/images/article1.jpg',
    ),
    Article(
      title: 'Raih Kekayaan dari Tutup Botol',
      date: '24 Nov 2024',
      badge: 'Populer',
      badgeColor: WasteWiseTheme.accentOrange,
      imageUrl: 'assets/images/article2.jpg',
    ),
    Article(
      title: 'Kompos Rumahan untuk Pemula',
      date: '23 Nov 2024',
      badge: null,
      badgeColor: null,
      imageUrl: 'assets/images/article3.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _breathingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pageController = PageController();
  }

  @override
  void dispose() {
    _particleController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    _breathingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(),

          // Particle System
          if (_showParticles) _buildParticleSystem(),

          // Main Content
          _buildMainContent(),

          // Floating Action Elements
          _buildFloatingElements(),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                _gradientColors[0].withOpacity(0.8),
                _gradientColors[1].withOpacity(0.6),
                _gradientColors[2].withOpacity(0.4),
                Colors.black.withOpacity(0.9),
              ],
              stops: const [0.0, 0.3, 0.6, 1.0],
            ),
          ),
          child: CustomPaint(
            painter: GeometricShapesPainter(_rotationController.value),
            size: Size.infinite,
          ),
        );
      },
    );
  }

  Widget _buildParticleSystem() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticleSystemPainter(_particleController.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Hero Header
          SliverToBoxAdapter(child: _buildHeroHeader()),

          // Interactive Dashboard Cards
          SliverToBoxAdapter(child: _buildInteractiveDashboard()),

          // Statistics Cards
          SliverToBoxAdapter(child: _buildStatisticsCards()),

          // Feature Cards
          SliverToBoxAdapter(child: _buildFeatureCards()),

          // Action Center
          SliverToBoxAdapter(child: _buildActionCenter()),

          // Achievements Section
          SliverToBoxAdapter(child: _buildAchievements()),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          // Background Glass Effect using existing GlassCard
          Positioned.fill(
            child: GlassCard(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Animated Avatar
                  FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    child: AnimatedBuilder(
                      animation: _breathingController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_breathingController.value * 0.05),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  WasteWiseTheme.primaryGreen,
                                  WasteWiseTheme.secondaryGreen,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: WasteWiseTheme.primaryGreen
                                      .withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Text(
                            'Welcome Back, Kairos',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),

                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Text(
                            'Ready to make a difference today?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Notification Bell
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child:
                                Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.red.withOpacity(0.6),
                                            blurRadius: 6,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                    )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .scale(
                                      begin: const Offset(0.8, 0.8),
                                      end: const Offset(1.2, 1.2),
                                      duration: 1000.ms,
                                      curve: Curves.easeInOut,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Points Display
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: Row(
                  children: [
                    Icon(
                      Icons.eco,
                      color: WasteWiseTheme.primaryGreen,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: 16500),
                      duration: const Duration(milliseconds: 2000),
                      builder: (context, value, child) {
                        return Text(
                          '$value Points',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Level Progress
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Level 4 - Eco Warrior',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '80%',
                          style: TextStyle(
                            color: WasteWiseTheme.primaryGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 0.8),
                        duration: const Duration(milliseconds: 1500),
                        builder: (context, value, child) {
                          return FractionallySizedBox(
                            widthFactor: value,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                gradient: LinearGradient(
                                  colors: [
                                    WasteWiseTheme.primaryGreen,
                                    WasteWiseTheme.secondaryGreen,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: WasteWiseTheme.primaryGreen
                                        .withOpacity(0.5),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
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
    );
  }

  Widget _buildInteractiveDashboard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SlideInUp(
        duration: const Duration(milliseconds: 800),
        child: GlassCard(
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  WasteWiseTheme.primaryGreen.withOpacity(0.3),
                  WasteWiseTheme.secondaryGreen.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today\'s Impact',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'CO₂ Saved',
                        '2.4 kg',
                        Icons.cloud_off,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Items Recycled',
                        '12',
                        Icons.recycling,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        'Points Earned',
                        '340',
                        Icons.star,
                        Colors.amber,
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

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCards() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatsCard('Waste Sorted', 2847, 'kg', Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatsCard('Trees Saved', 23, 'trees', Colors.brown),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatsCard('Water Saved', 1420, 'L', Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, int value, String unit, Color color) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: GlassCard(
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: value),
                duration: const Duration(milliseconds: 1000),
                builder: (context, animatedValue, child) {
                  return Text(
                    '$animatedValue $unit',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCards() {
    final features = [
      FeatureCard(
        'AI Scan',
        Icons.camera_alt,
        'Smart waste classification',
        Colors.purple,
      ),
      FeatureCard(
        'Marketplace',
        Icons.shopping_bag,
        'Exchange points for rewards',
        Colors.orange,
      ),
      FeatureCard('Community', Icons.group, 'Join eco challenges', Colors.blue),
      FeatureCard(
        'Education',
        Icons.school,
        'Learn sustainability',
        Colors.green,
      ),
    ];

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: PageView.builder(
        controller: _pageController,
        itemCount: features.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final feature = features[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
              },
              child: AnimatedScale(
                scale: index == _currentPage ? 1.0 : 0.85,
                duration: const Duration(milliseconds: 300),
                child: GlassCard(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          feature.color.withOpacity(0.3),
                          feature.color.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                feature.color,
                                feature.color.withOpacity(0.7),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: feature.color.withOpacity(0.5),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: Icon(
                            feature.icon,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          feature.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          feature.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionCenter() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildActionCard('Scan Now', Icons.qr_code_scanner, Colors.green),
              _buildActionCard('Find Bins', Icons.location_on, Colors.blue),
              _buildActionCard('Track Impact', Icons.analytics, Colors.purple),
              _buildActionCard(
                'Earn Rewards',
                Icons.card_giftcard,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
      },
      child: GlassCard(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInRight(
            child: Text(
              'Recent Achievements',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),

          ...List.generate(3, (index) {
            final achievements = [
              {
                'title': 'Eco Pioneer',
                'desc': 'Recycled 100+ items',
                'color': Colors.green,
              },
              {
                'title': 'Point Master',
                'desc': 'Earned 10,000 points',
                'color': Colors.amber,
              },
              {
                'title': 'Community Hero',
                'desc': 'Helped 50+ neighbors',
                'color': Colors.blue,
              },
            ];

            final achievement = achievements[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SlideInRight(
                delay: Duration(milliseconds: 200 * index),
                child: GlassCard(
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          (achievement['color'] as Color).withOpacity(0.2),
                          (achievement['color'] as Color).withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                achievement['color'] as Color,
                                (achievement['color'] as Color).withOpacity(
                                  0.7,
                                ),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                achievement['title'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                achievement['desc'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withOpacity(0.5),
                          size: 16,
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

  Widget _buildFloatingElements() {
    return Positioned(
      bottom: 30,
      right: 30,
      child: Column(
        children: [
          // Floating Scan Button
          GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
            },
            child: AnimatedBuilder(
              animation: _breathingController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_breathingController.value * 0.1),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          WasteWiseTheme.primaryGreen,
                          WasteWiseTheme.secondaryGreen,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: WasteWiseTheme.primaryGreen.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Particle Toggle Button
          GestureDetector(
            onTap: () {
              setState(() {
                _showParticles = !_showParticles;
              });
              HapticFeedback.selectionClick();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                _showParticles ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painters for Background Effects
class GeometricShapesPainter extends CustomPainter {
  final double animationValue;

  GeometricShapesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw rotating geometric shapes
    for (int i = 0; i < 5; i++) {
      paint.color = Colors.white.withOpacity(0.1 - (i * 0.02));

      final center = Offset(
        size.width * (0.2 + i * 0.15),
        size.height * (0.3 + i * 0.1),
      );

      final radius = 50.0 + (i * 20);
      final rotation = animationValue * 2 * math.pi + (i * math.pi / 3);

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotation);

      // Draw hexagon
      final path = Path();
      for (int j = 0; j < 6; j++) {
        final angle = j * math.pi / 3;
        final x = radius * math.cos(angle);
        final y = radius * math.sin(angle);
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();

      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParticleSystemPainter extends CustomPainter {
  final double animationValue;
  static final List<Particle> _particles = [];

  ParticleSystemPainter(this.animationValue) {
    if (_particles.isEmpty) {
      for (int i = 0; i < 50; i++) {
        _particles.add(Particle());
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in _particles) {
      particle.update(size, animationValue);

      paint.color = particle.color;
      canvas.drawCircle(Offset(particle.x, particle.y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  late double x, y, vx, vy, size;
  late Color color;
  late double life;

  Particle() {
    reset();
  }

  void reset() {
    x = math.Random().nextDouble() * 400;
    y = math.Random().nextDouble() * 800;
    vx = (math.Random().nextDouble() - 0.5) * 2;
    vy = (math.Random().nextDouble() - 0.5) * 2;
    size = math.Random().nextDouble() * 3 + 1;
    life = math.Random().nextDouble();

    final colors = [
      Colors.green.withOpacity(0.6),
      Colors.blue.withOpacity(0.4),
      Colors.purple.withOpacity(0.3),
      Colors.orange.withOpacity(0.5),
    ];
    color = colors[math.Random().nextInt(colors.length)];
  }

  void update(Size size, double time) {
    x += vx;
    y += vy;
    life -= 0.01;

    if (life <= 0 || x < 0 || x > size.width || y < 0 || y > size.height) {
      reset();
      x = math.Random().nextDouble() * size.width;
      y = math.Random().nextDouble() * size.height;
    }
  }
}

// Data Models
class FeatureCard {
  final String title;
  final IconData icon;
  final String description;
  final Color color;

  FeatureCard(this.title, this.icon, this.description, this.color);
}

class WasteCategory {
  final String name;
  final double weight;
  final IconData icon;
  final Color color;
  final String unit;

  WasteCategory({
    required this.name,
    required this.weight,
    required this.icon,
    required this.color,
    required this.unit,
  });
}

class QuickAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  QuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });
}

class Article {
  final String title;
  final String date;
  final String? badge;
  final Color? badgeColor;
  final String imageUrl;

  Article({
    required this.title,
    required this.date,
    this.badge,
    this.badgeColor,
    required this.imageUrl,
  });
}
