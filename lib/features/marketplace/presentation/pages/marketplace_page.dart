import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/gamified_button.dart';
import 'package:wastewise/shared/widgets/image_placeholder.dart';
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
      originalPrice: 10,
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
      originalPrice: 7,
      imageUrl: 'assets/images/tshirt.png',
      category: 'Fashion',
      rating: 4.6,
      isPopular: false,
    ),
    MarketplaceItem(
      id: '3',
      name: 'Solar Power Bank',
      description: 'Portable solar charger with 10000mAh capacity',
      points: 1500,
      originalPrice: 30,
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
      originalPrice: 6,
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
                        'Eco-friendly products',
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
          hintText: 'Search products...',
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
          childAspectRatio: 0.58, // Further reduced to give more height
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
                child: Stack(
                  children: [
                    // Product Image Placeholder
                    ImagePlaceholder(
                      width: double.infinity,
                      height: double.infinity,
                      category: item.category,
                      name: item.name,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(WasteWiseTheme.radiusLarge),
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
              
              // Product Info
              Expanded(
                flex: 4, // Further increased flex for more space
                child: Padding(
                  padding: const EdgeInsets.all(6), // Further reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.name,
                        style: WasteWiseTheme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12, // Further reduced font size
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 1),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 12,
                            color: WasteWiseTheme.goldStar,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            item.rating.toString(),
                            style: WasteWiseTheme.textTheme.labelSmall
                                ?.copyWith(
                                  color: WasteWiseTheme.secondaryText,
                                  fontSize: 11,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Price and Points
                      Text(
                        '${item.points} pts',
                        style: WasteWiseTheme.textTheme.titleSmall?.copyWith(
                          color: WasteWiseTheme.primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '\$${_formatPrice(item.originalPrice)}',
                        style: WasteWiseTheme.textTheme.labelSmall?.copyWith(
                          color: WasteWiseTheme.secondaryText,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Exchange Button
                      SizedBox(
                        width: double.infinity,
                        height: 26, // Further reduced button height
                        child: GamifiedButton(
                          text: canAfford ? 'Exchange' : 'Not Enough',
                          onPressed: canAfford
                              ? () => _showPurchaseDialog(item)
                              : null,
                          variant: canAfford
                              ? ButtonVariant.primary
                              : ButtonVariant.ghost,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          fontSize: 10,
                        ),
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

  LinearGradient _getProductGradient(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return LinearGradient(
          colors: [
            WasteWiseTheme.accentBlue,
            WasteWiseTheme.accentBlue.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'fashion':
        return LinearGradient(
          colors: [
            WasteWiseTheme.accentPurple,
            WasteWiseTheme.accentPurple.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'home & garden':
        return LinearGradient(
          colors: [
            WasteWiseTheme.primaryGreen,
            WasteWiseTheme.primaryGreen.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [
            WasteWiseTheme.accentOrange,
            WasteWiseTheme.accentOrange.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  IconData _getProductIcon(String category, String productName) {
    // First check specific product names
    if (productName.toLowerCase().contains('bottle')) {
      return Icons.water_drop;
    } else if (productName.toLowerCase().contains('shirt') ||
        productName.toLowerCase().contains('cotton')) {
      return Icons.checkroom;
    } else if (productName.toLowerCase().contains('power') ||
        productName.toLowerCase().contains('solar')) {
      return Icons.battery_charging_full;
    } else if (productName.toLowerCase().contains('lunch') ||
        productName.toLowerCase().contains('bamboo')) {
      return Icons.lunch_dining;
    }

    // Then check by category
    switch (category.toLowerCase()) {
      case 'electronics':
        return Icons.devices;
      case 'fashion':
        return Icons.checkroom;
      case 'home & garden':
        return Icons.home_work;
      case 'books':
        return Icons.book;
      case 'vouchers':
        return Icons.card_giftcard;
      default:
        return Icons.eco;
    }
  }

  void _showPurchaseDialog(MarketplaceItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WasteWiseTheme.radiusLarge),
        ),
        title: Text(
          'Confirm Exchange',
          style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to exchange ${item.points} points for:',
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
              'Current points: $_userPoints',
              style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                color: WasteWiseTheme.secondaryText,
              ),
            ),
            Text(
              'Points after exchange: ${_userPoints - item.points}',
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
              'Cancel',
              style: TextStyle(color: WasteWiseTheme.secondaryText),
            ),
          ),
          GamifiedButton(
            text: 'Exchange Now',
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
                'Successfully exchanged ${item.name}! Product will be shipped in 3-5 business days.',
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
