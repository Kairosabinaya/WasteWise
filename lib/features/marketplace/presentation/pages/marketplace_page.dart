import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/gamified_button.dart';
import 'package:wastewise/shared/widgets/points_badge.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategoryIndex = 0;
  final int _userPoints = 2450; // Mock user points

  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Books',
    'Vouchers',
  ];

  final List<MarketplaceItem> _featuredItems = [
    MarketplaceItem(
      id: '1',
      name: 'Eco-Friendly Water Bottle',
      description: 'Stainless steel water bottle made from recycled materials',
      points: 500,
      originalPrice: 150000,
      imageUrl: 'assets/images/water_bottle.png',
      category: 'Electronics',
      rating: 4.8,
      isPopular: true,
    ),
    MarketplaceItem(
      id: '2',
      name: 'Organic Cotton T-Shirt',
      description: '100% organic cotton, sustainably produced',
      points: 350,
      originalPrice: 120000,
      imageUrl: 'assets/images/tshirt.png',
      category: 'Fashion',
      rating: 4.6,
      isPopular: false,
    ),
    MarketplaceItem(
      id: '3',
      name: 'Solar Power Bank',
      description: 'Portable solar charger with 10000mAh capacity',
      points: 800,
      originalPrice: 250000,
      imageUrl: 'assets/images/powerbank.png',
      category: 'Electronics',
      rating: 4.9,
      isPopular: true,
    ),
    MarketplaceItem(
      id: '4',
      name: 'Bamboo Lunch Box',
      description: 'Sustainable bamboo lunch container set',
      points: 300,
      originalPrice: 80000,
      imageUrl: 'assets/images/lunchbox.png',
      category: 'Home & Garden',
      rating: 4.5,
      isPopular: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WasteWiseTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategoryTabs(),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
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
                    'Marketplace',
                    style: WasteWiseTheme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3),
                  const SizedBox(height: 4),
                  Text(
                        'Tukar poin dengan produk eco-friendly',
                        style: WasteWiseTheme.textTheme.bodyMedium?.copyWith(
                          color: WasteWiseTheme.secondaryText,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideX(begin: -0.3),
                ],
              ),
              PointsBadge(points: _userPoints, showAnimation: true)
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 400.ms)
                  .scale(begin: const Offset(0.8, 0.8)),
            ],
          ),
          const SizedBox(height: WasteWiseTheme.spacing16),
          _buildSearchBar()
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms)
              .slideY(begin: 0.3),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GlassCard(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari produk...',
          prefixIcon: const Icon(
            Icons.search,
            color: WasteWiseTheme.secondaryText,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: WasteWiseTheme.spacing16,
            vertical: WasteWiseTheme.spacing12,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: WasteWiseTheme.spacing16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
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
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [
                              WasteWiseTheme.primaryGreen,
                              WasteWiseTheme.secondaryGreen,
                            ],
                          )
                        : null,
                    color: isSelected ? null : WasteWiseTheme.surface,
                    borderRadius: BorderRadius.circular(
                      WasteWiseTheme.radiusLarge,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : WasteWiseTheme.glassStroke,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _categories[index],
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
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: (index * 100).ms)
              .slideX(begin: 0.3);
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: WasteWiseTheme.spacing12,
          mainAxisSpacing: WasteWiseTheme.spacing12,
          childAspectRatio: 0.75,
        ),
        itemCount: _featuredItems.length,
        itemBuilder: (context, index) {
          final item = _featuredItems[index];
          return _buildProductCard(item, index);
        },
      ),
    );
  }

  Widget _buildProductCard(MarketplaceItem item, int index) {
    final canAfford = _userPoints >= item.points;

    return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: WasteWiseTheme.lightGreen.withOpacity(0.3),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(WasteWiseTheme.radiusLarge),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.eco,
                          size: 48,
                          color: WasteWiseTheme.primaryGreen.withOpacity(0.6),
                        ),
                      ),
                      if (item.isPopular)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: WasteWiseTheme.accentOrange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Popular',
                              style: WasteWiseTheme.textTheme.labelSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Product Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(WasteWiseTheme.spacing12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: WasteWiseTheme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: WasteWiseTheme.goldStar,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.rating.toString(),
                            style: WasteWiseTheme.textTheme.labelSmall
                                ?.copyWith(color: WasteWiseTheme.secondaryText),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.points} pts',
                                style: WasteWiseTheme.textTheme.titleMedium
                                    ?.copyWith(
                                      color: WasteWiseTheme.primaryGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Rp ${_formatPrice(item.originalPrice)}',
                                style: WasteWiseTheme.textTheme.labelSmall
                                    ?.copyWith(
                                      color: WasteWiseTheme.secondaryText,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            ],
                          ),
                          GamifiedButton(
                            text: canAfford ? 'Tukar' : 'Tidak Cukup',
                            onPressed: canAfford
                                ? () => _showPurchaseDialog(item)
                                : null,
                            variant: canAfford
                                ? ButtonVariant.primary
                                : ButtonVariant.ghost,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: (index * 100).ms)
        .slideY(begin: 0.3);
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  void _showPurchaseDialog(MarketplaceItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WasteWiseTheme.radiusLarge),
        ),
        title: Text(
          'Konfirmasi Penukaran',
          style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apakah Anda yakin ingin menukar ${item.points} poin untuk:',
              style: WasteWiseTheme.textTheme.bodyMedium,
            ),
            const SizedBox(height: WasteWiseTheme.spacing12),
            Text(
              item.name,
              style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: WasteWiseTheme.primaryGreen,
              ),
            ),
            const SizedBox(height: WasteWiseTheme.spacing8),
            Text(
              'Poin saat ini: $_userPoints',
              style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                color: WasteWiseTheme.secondaryText,
              ),
            ),
            Text(
              'Poin setelah penukaran: ${_userPoints - item.points}',
              style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                color: WasteWiseTheme.secondaryText,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Batal',
              style: TextStyle(color: WasteWiseTheme.secondaryText),
            ),
          ),
          GamifiedButton(
            text: 'Tukar Sekarang',
            onPressed: () {
              Navigator.of(context).pop();
              _processPurchase(item);
            },
            variant: ButtonVariant.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            fontSize: 14,
          ),
        ],
      ),
    );
  }

  void _processPurchase(MarketplaceItem item) {
    // Show success animation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: WasteWiseTheme.primaryGreen,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: WasteWiseTheme.spacing8),
            Expanded(
              child: Text(
                'Berhasil menukar ${item.name}! Produk akan dikirim dalam 3-5 hari kerja.',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WasteWiseTheme.radiusLarge),
        ),
      ),
    );
  }
}

class MarketplaceItem {
  final String id;
  final String name;
  final String description;
  final int points;
  final int originalPrice;
  final String imageUrl;
  final String category;
  final double rating;
  final bool isPopular;

  MarketplaceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.originalPrice,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.isPopular,
  });
}
