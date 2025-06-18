import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/custom_bottom_navigation.dart';
import 'package:wastewise/features/scan/presentation/pages/scan_page.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  int _selectedTab = 0; // 0: Achievements, 1: Rewards

  // Same color palette as home_page.dart
  static const Color _backgroundColor = Color(0xFFF8FAFC);
  static const Color _primaryGreen = Color(0xFF10B981);
  static const Color _lightGreen = Color(0xFFECFDF5);
  static const Color _textPrimary = Color(0xFF1F2937);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _surfaceWhite = Color(0xFFFFFFFF);
  static const Color _organicGreen = Color(0xFF059669);
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

  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'Eco Pioneer',
      'description': 'Recycle your first 10 items',
      'progress': 1.0,
      'points': 500,
      'icon': LucideIcons.leaf,
      'color': _organicGreen,
      'isCompleted': true,
      'completedDate': '2 days ago',
    },
    {
      'title': 'Recycling Champion',
      'description': 'Recycle 100 items in total',
      'progress': 0.85,
      'points': 1000,
      'icon': LucideIcons.recycle,
      'color': _recycleBlue,
      'isCompleted': false,
      'current': 85,
      'target': 100,
    },
    {
      'title': 'Green Streak',
      'description': 'Recycle for 30 consecutive days',
      'progress': 0.6,
      'points': 800,
      'icon': LucideIcons.flame,
      'color': _hazardOrange,
      'isCompleted': false,
      'current': 18,
      'target': 30,
    },
    {
      'title': 'Community Helper',
      'description': 'Help 20 community members',
      'progress': 0.35,
      'points': 600,
      'icon': LucideIcons.users,
      'color': _rewardPurple,
      'isCompleted': false,
      'current': 7,
      'target': 20,
    },
    {
      'title': 'Point Master',
      'description': 'Earn 10,000 total points',
      'progress': 0.92,
      'points': 1500,
      'icon': LucideIcons.star,
      'color': _statCoral,
      'isCompleted': false,
      'current': 9200,
      'target': 10000,
    },
  ];

  final List<Map<String, dynamic>> _rewards = [
    {
      'title': 'Coffee Shop Voucher',
      'description': '50% off at EcoBean Coffee',
      'points': 500,
      'originalPrice': '\$12',
      'discountedPrice': '\$6',
      'category': 'Food & Drink',
      'icon': LucideIcons.coffee,
      'color': _hazardOrange,
      'isRedeemed': false,
    },
    {
      'title': 'Eco-Friendly Water Bottle',
      'description': 'Sustainable bamboo water bottle',
      'points': 800,
      'originalPrice': '\$25',
      'discountedPrice': 'Free',
      'category': 'Lifestyle',
      'icon': LucideIcons.droplets,
      'color': _recycleBlue,
      'isRedeemed': false,
    },
    {
      'title': 'Plant Seedling Kit',
      'description': 'Grow your own herbs at home',
      'points': 300,
      'originalPrice': '\$15',
      'discountedPrice': '\$5',
      'category': 'Garden',
      'icon': LucideIcons.leaf,
      'color': _organicGreen,
      'isRedeemed': true,
    },
    {
      'title': 'Recycled Notebook',
      'description': 'Made from 100% recycled paper',
      'points': 200,
      'originalPrice': '\$8',
      'discountedPrice': '\$3',
      'category': 'Stationery',
      'icon': LucideIcons.book,
      'color': _rewardPurple,
      'isRedeemed': false,
    },
  ];

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
              _buildPointsHeader(),
              _buildTabSelector(),
              Expanded(
                child: _selectedTab == 0
                    ? _buildAchievementsView()
                    : _buildRewardsView(),
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
        backgroundColor: const Color(0xFF8B5CF6),
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
          const Expanded(
            child: Text('Rewards & Achievements', style: _headingStyle),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
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
                LucideIcons.gift,
                color: _textPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 700),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_rewardPurple, _rewardPurple.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _rewardPurple.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.star,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Points Balance',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: 16500),
                    duration: const Duration(milliseconds: 1500),
                    builder: (context, value, child) {
                      return Text(
                        '$value Points',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Text(
                  'Level 4',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Eco Warrior',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(4),
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
            Expanded(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _selectedTab = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedTab == 0
                        ? _primaryGreen
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Achievements',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedTab == 0 ? Colors.white : _textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _selectedTab = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedTab == 1
                        ? _primaryGreen
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Rewards',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedTab == 1 ? Colors.white : _textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _buildAchievementItem(achievement),
          ),
        );
      },
    );
  }

  Widget _buildAchievementItem(Map<String, dynamic> achievement) {
    final isCompleted = achievement['isCompleted'] as bool;
    final progress = achievement['progress'] as double;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _showAchievementDetails(achievement);
      },
      child: GlassCard(
        child: Stack(
          children: [
            // Completion overlay
            if (isCompleted)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _primaryGreen,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'COMPLETED',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            achievement['color'] as Color,
                            (achievement['color'] as Color).withOpacity(0.8),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (achievement['color'] as Color).withOpacity(
                              0.3,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        achievement['icon'] as IconData,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            achievement['title'] as String,
                            style: _subheadingStyle.copyWith(fontSize: 15),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            achievement['description'] as String,
                            style: _captionStyle,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.star,
                                color: _hazardOrange,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${achievement['points']} points',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _hazardOrange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (!isCompleted) ...[
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: _captionStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${achievement['current']}/${achievement['target']}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: achievement['color'] as Color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(
                          achievement['color'] as Color,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                ],
                if (isCompleted) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _lightGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Completed ${achievement['completedDate']}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _primaryGreen,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _rewards.length,
      itemBuilder: (context, index) {
        final reward = _rewards[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _buildRewardItem(reward),
          ),
        );
      },
    );
  }

  Widget _buildRewardItem(Map<String, dynamic> reward) {
    final isRedeemed = reward['isRedeemed'] as bool;
    final canAfford =
        16500 >= (reward['points'] as int); // Current points >= required points

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (!isRedeemed && canAfford) {
          _redeemReward(reward);
        }
      },
      child: GlassCard(
        child: Stack(
          children: [
            // Redeemed overlay
            if (isRedeemed)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _textSecondary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'REDEEMED',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        reward['color'] as Color,
                        (reward['color'] as Color).withOpacity(0.8),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (reward['color'] as Color).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    reward['icon'] as IconData,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward['title'] as String,
                        style: _subheadingStyle.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        reward['description'] as String,
                        style: _captionStyle,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (reward['color'] as Color).withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              reward['category'] as String,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: reward['color'] as Color,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.star,
                                    color: _hazardOrange,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${reward['points']} points',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _hazardOrange,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    reward['originalPrice'] as String,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _textSecondary,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    reward['discountedPrice'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _primaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAchievementDetails(Map<String, dynamic> achievement) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
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
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                achievement['title'] as String,
                style: _headingStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                achievement['description'] as String,
                style: _captionStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _primaryGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _redeemReward(Map<String, dynamic> reward) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.gift, color: _primaryGreen, size: 48),
              const SizedBox(height: 16),
              Text(
                'Redeem Reward?',
                style: _headingStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'This will cost ${reward['points']} points',
                style: _captionStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _textSecondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pop(context);
                        // TODO: Implement actual redemption logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${reward['title']} redeemed successfully!',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Redeem',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
