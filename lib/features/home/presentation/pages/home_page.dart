import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  late AnimationController _headerController;
  late AnimationController _cardController;
  int _selectedArticleTab = 0;

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
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerController.forward();
    _cardController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WasteWiseTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            _buildDaurPoinPanel(),
            _buildWasteActivityData(),
            _buildQuickActions(),
            _buildArticlesSection(),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(WasteWiseTheme.spacing20),
        decoration: BoxDecoration(
          color: WasteWiseTheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // User Avatar
            Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        WasteWiseTheme.primaryGreen,
                        WasteWiseTheme.secondaryGreen,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                )
                .animate(controller: _headerController)
                .fadeIn(duration: 600.ms)
                .slideX(begin: -0.3),

            const SizedBox(width: WasteWiseTheme.spacing16),

            // Greeting
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        'Selamat Datang, Kairos',
                        style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                      .animate(controller: _headerController)
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideX(begin: -0.3),

                  const SizedBox(height: 4),

                  Row(
                        children: [
                          Icon(
                            Icons.eco,
                            size: 16,
                            color: WasteWiseTheme.primaryGreen,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: PointsBadge(
                              points: 16500,
                              showAnimation: true,
                            ),
                          ),
                        ],
                      )
                      .animate(controller: _headerController)
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideX(begin: -0.3),
                ],
              ),
            ),

            // Notification Bell
            Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: WasteWiseTheme.lightGreen.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: WasteWiseTheme.primaryGreen,
                          size: 24,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: WasteWiseTheme.accentRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate(controller: _headerController)
                .fadeIn(duration: 600.ms, delay: 600.ms)
                .scale(begin: const Offset(0.8, 0.8)),
          ],
        ),
      ),
    );
  }

  Widget _buildDaurPoinPanel() {
    return SliverToBoxAdapter(
      child:
          Container(
                margin: const EdgeInsets.all(WasteWiseTheme.spacing20),
                child: GlassCard(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFA1E5B0), Color(0xFF4CAF50)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        WasteWiseTheme.radiusLarge,
                      ),
                    ),
                    padding: const EdgeInsets.all(WasteWiseTheme.spacing20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.eco,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'WastePoint Aktif',
                                      style: WasteWiseTheme
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GamifiedButton(
                                  text: 'Tukar Poin ➤',
                                  onPressed: () {},
                                  variant: ButtonVariant.secondary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  fontSize: 11,
                                )
                                .animate()
                                .shimmer(duration: 2000.ms, delay: 1000.ms)
                                .then()
                                .shake(duration: 500.ms),
                          ],
                        ),

                        const SizedBox(height: WasteWiseTheme.spacing16),

                        Text(
                          '16,500 Poin',
                          style: WasteWiseTheme.textTheme.displaySmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: WasteWiseTheme.spacing12),

                        Wrap(
                          spacing: 16,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Masuk: 26,600',
                                  style: WasteWiseTheme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Keluar: 10,100',
                                  style: WasteWiseTheme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: WasteWiseTheme.spacing16),

                        // Progress to next level
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    '80% Menuju Level Berikutnya',
                                    style: WasteWiseTheme.textTheme.bodySmall
                                        ?.copyWith(color: Colors.white70),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  'Level 4',
                                  style: WasteWiseTheme.textTheme.bodySmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.8,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate(controller: _cardController)
              .fadeIn(duration: 800.ms)
              .slideY(begin: 0.3),
    );
  }

  Widget _buildWasteActivityData() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WasteWiseTheme.spacing20,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.recycling,
                  color: WasteWiseTheme.primaryGreen,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Sampah Didaur Ulang',
                    style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.info_outline,
                  color: WasteWiseTheme.secondaryText,
                  size: 16,
                ),
              ],
            ),
          ),

          const SizedBox(height: WasteWiseTheme.spacing16),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WasteWiseTheme.spacing20,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: WasteWiseTheme.spacing12,
                mainAxisSpacing: WasteWiseTheme.spacing12,
              ),
              itemCount: _wasteData.length,
              itemBuilder: (context, index) {
                final waste = _wasteData[index];
                return GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.all(WasteWiseTheme.spacing8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: waste.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                waste.icon,
                                color: waste.color,
                                size: 18,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${waste.weight} ${waste.unit}',
                              style: WasteWiseTheme.textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: waste.color,
                                    fontSize: 14,
                                  ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              waste.name,
                              style: WasteWiseTheme.textTheme.bodySmall
                                  ?.copyWith(
                                    color: WasteWiseTheme.secondaryText,
                                    fontSize: 12,
                                  ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate(delay: (index * 100).ms)
                    .fadeIn(duration: 600.ms)
                    .scale(begin: const Offset(0.8, 0.8));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: WasteWiseTheme.spacing32),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WasteWiseTheme.spacing20,
            ),
            child: Text(
              'Jelajahi Fitur WasteWise',
              style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: WasteWiseTheme.spacing16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: WasteWiseTheme.spacing20,
            ),
            itemCount: _quickActions.length,
            itemBuilder: (context, index) {
              final action = _quickActions[index];
              return Container(
                    margin: const EdgeInsets.only(
                      bottom: WasteWiseTheme.spacing12,
                    ),
                    child: GlassCard(
                      child: InkWell(
                        onTap: () {
                          // Navigate to respective page
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Navigating to ${action.title}'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(
                          WasteWiseTheme.radiusLarge,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            WasteWiseTheme.spacing16,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: action.color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  action.icon,
                                  color: action.color,
                                  size: 24,
                                ),
                              ),

                              const SizedBox(width: WasteWiseTheme.spacing16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      action.title,
                                      style: WasteWiseTheme
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      action.subtitle,
                                      style: WasteWiseTheme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: WasteWiseTheme.secondaryText,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              Icon(
                                Icons.arrow_forward_ios,
                                color: WasteWiseTheme.secondaryText,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .animate(delay: (index * 100).ms)
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: 0.3);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: WasteWiseTheme.spacing32),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: WasteWiseTheme.spacing20,
            ),
            child: Text(
              'Edukasi & Inspirasi',
              style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: WasteWiseTheme.spacing16),

          // Tab Bar
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(
              horizontal: WasteWiseTheme.spacing20,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _articleTabs.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedArticleTab;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedArticleTab = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: WasteWiseTheme.spacing12,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: WasteWiseTheme.spacing20,
                      vertical: WasteWiseTheme.spacing8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? WasteWiseTheme.primaryGreen
                          : WasteWiseTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : WasteWiseTheme.glassStroke,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _articleTabs[index],
                        style: WasteWiseTheme.textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? Colors.white
                              : WasteWiseTheme.primaryText,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: WasteWiseTheme.spacing16),

          // Articles Carousel
          SizedBox(
            height: 220, // Increased height from 200 to 220
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: WasteWiseTheme.spacing20,
              ),
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                final article = _articles[index];
                return Container(
                      width: 240, // Reduced width from 260 to 240
                      margin: const EdgeInsets.only(
                        right: WasteWiseTheme.spacing12, // Reduced margin
                      ),
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize:
                              MainAxisSize.min, // Added to prevent overflow
                          children: [
                            // Article Image
                            Container(
                              height: 120, // Fixed height instead of Expanded
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: WasteWiseTheme.lightGreen.withOpacity(
                                  0.3,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(
                                    WasteWiseTheme.radiusLarge,
                                  ),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.article,
                                      size: 40, // Reduced from 48 to 40
                                      color: WasteWiseTheme.primaryGreen
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                  if (article.badge != null)
                                    Positioned(
                                      top: 8, // Reduced from 12 to 8
                                      left: 8, // Reduced from 12 to 8
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6, // Reduced from 8 to 6
                                          vertical: 3, // Reduced from 4 to 3
                                        ),
                                        decoration: BoxDecoration(
                                          color: article.badgeColor,
                                          borderRadius: BorderRadius.circular(
                                            10, // Reduced from 12 to 10
                                          ),
                                        ),
                                        child: Text(
                                          article.badge!,
                                          style: WasteWiseTheme
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    10, // Explicitly set smaller font
                                              ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Article Info
                            Container(
                              height: 80, // Fixed height instead of Expanded
                              padding: const EdgeInsets.all(
                                WasteWiseTheme.spacing8, // Reduced padding
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    article.title,
                                    style: WasteWiseTheme.textTheme.titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              13, // Explicitly set smaller font
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    article.date,
                                    style: WasteWiseTheme.textTheme.bodySmall
                                        ?.copyWith(
                                          color: WasteWiseTheme.secondaryText,
                                          fontSize:
                                              11, // Explicitly set smaller font
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate(delay: (index * 150).ms)
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: 0.3);
              },
            ),
          ),
        ],
      ),
    );
  }
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
