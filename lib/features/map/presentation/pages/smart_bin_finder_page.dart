import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/custom_bottom_navigation.dart';
import 'package:wastewise/features/scan/presentation/pages/scan_page.dart';

class SmartBinFinderPage extends StatefulWidget {
  final bool showBottomNavigation;

  const SmartBinFinderPage({super.key, this.showBottomNavigation = true});

  @override
  State<SmartBinFinderPage> createState() => _SmartBinFinderPageState();
}

class _SmartBinFinderPageState extends State<SmartBinFinderPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  String _selectedFilter = 'All';

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
  static const Color _residueGray = Color(0xFF6B7280);

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

  final List<Map<String, dynamic>> _smartBins = [
    {
      'name': 'Central Park Smart Bin',
      'distance': '0.2 km',
      'types': ['Organic', 'Recyclable'],
      'status': 'Available',
      'address': '123 Green Street, Downtown',
      'capacity': 85,
      'icon': LucideIcons.trash2,
      'color': _primaryGreen,
    },
    {
      'name': 'University Campus Bin',
      'distance': '0.5 km',
      'types': ['Recyclable', 'Hazardous'],
      'status': 'Full',
      'address': '456 Education Ave, Campus',
      'capacity': 100,
      'icon': LucideIcons.recycle,
      'color': _recycleBlue,
    },
    {
      'name': 'Shopping Mall Hub',
      'distance': '0.8 km',
      'types': ['All Types'],
      'status': 'Available',
      'address': '789 Commerce Blvd, Mall District',
      'capacity': 42,
      'icon': LucideIcons.package,
      'color': _hazardOrange,
    },
    {
      'name': 'Community Center Bin',
      'distance': '1.2 km',
      'types': ['Organic', 'Residual'],
      'status': 'Available',
      'address': '321 Community Dr, Residential',
      'capacity': 67,
      'icon': LucideIcons.home,
      'color': _organicGreen,
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
              _buildMapPlaceholder(),
              _buildFilterSection(),
              Expanded(child: _buildSmartBinsList()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.showBottomNavigation
          ? const CustomBottomNavigation(currentIndex: 1)
          : null,
      floatingActionButton: widget.showBottomNavigation
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanPage()),
                );
              },
              backgroundColor: const Color(0xFF8B5CF6),
              child: const Icon(
                LucideIcons.qrCode,
                color: Colors.white,
                size: 28,
              ),
            )
          : null,
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
          const Expanded(child: Text('Smart Bin Finder', style: _headingStyle)),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _toggleMapView();
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
              child: const Icon(LucideIcons.map, color: _textPrimary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPlaceholder() {
    return FadeInDown(
      duration: const Duration(milliseconds: 700),
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_primaryGreen, _primaryGreen.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _primaryGreen.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Map Pattern Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: CustomPaint(painter: MapPatternPainter()),
              ),
            ),
            // Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            LucideIcons.mapPin,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Location',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Downtown District',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '4 Smart Bins Nearby',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Tap to view map',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildFilterSection() {
    final filters = ['All', 'Organic', 'Recyclable', 'Hazardous', 'Residual'];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filter by Waste Type', style: _subheadingStyle),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                Color filterColor = _primaryGreen;

                switch (filter) {
                  case 'Organic':
                    filterColor = _organicGreen;
                    break;
                  case 'Recyclable':
                    filterColor = _recycleBlue;
                    break;
                  case 'Hazardous':
                    filterColor = _hazardOrange;
                    break;
                  case 'Residual':
                    filterColor = _residueGray;
                    break;
                }

                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? filterColor : _surfaceWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : filterColor.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : filterColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartBinsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _smartBins.length,
      itemBuilder: (context, index) {
        final bin = _smartBins[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _buildSmartBinItem(bin),
          ),
        );
      },
    );
  }

  Widget _buildSmartBinItem(Map<String, dynamic> bin) {
    final isAvailable = bin['status'] == 'Available';
    final capacity = bin['capacity'] as int;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _showBinDetails(bin);
      },
      child: GlassCard(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        bin['color'] as Color,
                        (bin['color'] as Color).withOpacity(0.8),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (bin['color'] as Color).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    bin['icon'] as IconData,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              bin['name'] as String,
                              style: _subheadingStyle.copyWith(fontSize: 15),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isAvailable
                                  ? _primaryGreen.withOpacity(0.1)
                                  : _hazardOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              bin['status'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isAvailable
                                    ? _primaryGreen
                                    : _hazardOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bin['address'] as String,
                        style: _captionStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mapPin,
                            color: _textSecondary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            bin['distance'] as String,
                            style: _captionStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          ...((bin['types'] as List<String>)
                              .take(2)
                              .map(
                                (type) => Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _lightGreen,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    type,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600,
                                      color: _primaryGreen,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Capacity',
                            style: _captionStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '$capacity%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: capacity > 80
                                  ? _hazardOrange
                                  : _primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: capacity / 100,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(
                          capacity > 80 ? _hazardOrange : _primaryGreen,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _navigateToBin(bin);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.navigation,
                      color: _primaryGreen,
                      size: 16,
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

  void _toggleMapView() {
    // TODO: Toggle between list and map view
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Map view coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showBinDetails(Map<String, dynamic> bin) {
    // TODO: Show detailed bin information
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening details for ${bin['name']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToBin(Map<String, dynamic> bin) {
    // TODO: Open navigation to the bin
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to ${bin['name']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// Custom painter for map pattern
class MapPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw grid pattern
    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Draw some "roads"
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.6),
      Offset(size.width, size.height * 0.6),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
