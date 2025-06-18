import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/custom_bottom_navigation.dart';
import 'package:wastewise/features/scan/presentation/pages/scan_page.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  int _selectedPeriod = 0; // 0: Week, 1: Month, 2: Year

  // Using same color palette as home_page.dart
  static const Color _backgroundColor = Color(0xFFF8FAFC);
  static const Color _primaryGreen = Color(0xFF10B981);
  static const Color _lightGreen = Color(0xFFECFDF5);
  static const Color _textPrimary = Color(0xFF1F2937);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _surfaceWhite = Color(0xFFFFFFFF);
  static const Color _organicGreen = Color(0xFF059669);
  static const Color _recycleBlue = Color(0xFF0EA5E9);
  static const Color _hazardOrange = Color(0xFFF59E0B);
  static const Color _residueGray = Color(0xFF6B7280);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildPeriodSelector(),
                      const SizedBox(height: 24),
                      _buildOverviewStats(),
                      const SizedBox(height: 24),
                      _buildWasteChart(),
                      const SizedBox(height: 24),
                      _buildCategoryBreakdown(),
                      const SizedBox(height: 24),
                      _buildProgressTracking(),
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
          const Expanded(child: Text('Analytics', style: _headingStyle)),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              // TODO: Export analytics
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
                LucideIcons.download,
                color: _textPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['Week', 'Month', 'Year'];

    return FadeInDown(
      duration: const Duration(milliseconds: 700),
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
          children: periods.asMap().entries.map((entry) {
            final index = entry.key;
            final period = entry.value;
            final isSelected = _selectedPeriod == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  setState(() {
                    _selectedPeriod = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? _primaryGreen : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    period,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : _textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOverviewStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                'Total Waste',
                '42.8 kg',
                '+12% from last period',
                LucideIcons.trash2,
                _residueGray,
                true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOverviewCard(
                'CO₂ Saved',
                '15.2 kg',
                '+8% from last period',
                LucideIcons.leaf,
                _primaryGreen,
                true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                'Recycled',
                '28.4 kg',
                '+18% from last period',
                LucideIcons.recycle,
                _recycleBlue,
                true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOverviewCard(
                'Points Gained',
                '1,250',
                '+25% from last period',
                LucideIcons.star,
                _rewardPurple,
                false,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildOverviewCard(
    String title,
    String value,
    String change,
    IconData icon,
    Color color,
    bool isPositive,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Icon(
                isPositive ? LucideIcons.trendingUp : LucideIcons.trendingDown,
                color: isPositive ? _primaryGreen : _statCoral,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(title, style: _captionStyle),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 10,
              color: isPositive ? _primaryGreen : _statCoral,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWasteChart() {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Weekly Trend', style: _headingStyle),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              children: [
                _buildChartHeader(),
                const SizedBox(height: 20),
                _buildSimpleChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartHeader() {
    return Row(
      children: [
        _buildChartLegend('Organic', _organicGreen),
        const SizedBox(width: 16),
        _buildChartLegend('Recyclable', _recycleBlue),
        const SizedBox(width: 16),
        _buildChartLegend('Hazardous', _hazardOrange),
      ],
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: _captionStyle.copyWith(fontSize: 11)),
      ],
    );
  }

  Widget _buildSimpleChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final organicData = [2.1, 3.2, 1.8, 2.9, 3.5, 2.7, 1.9];
    final recyclableData = [1.8, 2.4, 3.1, 2.0, 2.8, 3.3, 2.6];
    final hazardousData = [0.1, 0.3, 0.0, 0.2, 0.4, 0.1, 0.2];

    return Container(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: days.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildStackedBar(
                    organicData[index],
                    recyclableData[index],
                    hazardousData[index],
                  ),
                  const SizedBox(height: 8),
                  Text(day, style: _captionStyle.copyWith(fontSize: 10)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStackedBar(double organic, double recyclable, double hazardous) {
    final maxHeight = 120.0;
    final total = organic + recyclable + hazardous;
    final scale = total > 0 ? maxHeight / 4.0 : 0; // Assuming max 4kg per day

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (hazardous > 0)
          Container(
            width: 20,
            height: hazardous * scale,
            decoration: BoxDecoration(
              color: _hazardOrange,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(2),
              ),
            ),
          ),
        if (recyclable > 0)
          Container(width: 20, height: recyclable * scale, color: _recycleBlue),
        if (organic > 0)
          Container(
            width: 20,
            height: organic * scale,
            decoration: BoxDecoration(
              color: _organicGreen,
              borderRadius: hazardous == 0 && recyclable == 0
                  ? const BorderRadius.vertical(top: Radius.circular(2))
                  : BorderRadius.zero,
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryBreakdown() {
    final categories = [
      {
        'name': 'Organic Waste',
        'amount': '18.2 kg',
        'percentage': 42,
        'color': _organicGreen,
      },
      {
        'name': 'Recyclable',
        'amount': '16.8 kg',
        'percentage': 39,
        'color': _recycleBlue,
      },
      {
        'name': 'Residual',
        'amount': '6.5 kg',
        'percentage': 15,
        'color': _residueGray,
      },
      {
        'name': 'Hazardous',
        'amount': '1.3 kg',
        'percentage': 4,
        'color': _hazardOrange,
      },
    ];

    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Category Breakdown', style: _headingStyle),
          const SizedBox(height: 16),
          ...categories.map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (category['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${category['percentage']}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: category['color'] as Color,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['name'] as String,
                    style: _subheadingStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(category['amount'] as String, style: _captionStyle),
                ],
              ),
            ),
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (category['percentage'] as int) / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: category['color'] as Color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTracking() {
    return FadeInUp(
      duration: const Duration(milliseconds: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Goals & Progress', style: _headingStyle),
          const SizedBox(height: 16),
          _buildProgressItem(
            'Monthly Recycling Goal',
            '28.4 kg',
            '40 kg',
            0.71,
            _recycleBlue,
          ),
          const SizedBox(height: 12),
          _buildProgressItem(
            'CO₂ Reduction Target',
            '15.2 kg',
            '20 kg',
            0.76,
            _primaryGreen,
          ),
          const SizedBox(height: 12),
          _buildProgressItem(
            'Points Goal',
            '1,250',
            '1,500',
            0.83,
            _rewardPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(
    String title,
    String current,
    String target,
    double progress,
    Color color,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: _subheadingStyle.copyWith(fontSize: 14)),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(current, style: _captionStyle),
              Text('of $target', style: _captionStyle),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(color),
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
