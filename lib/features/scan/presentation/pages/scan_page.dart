import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/gamified_button.dart';
import '../../../../shared/widgets/points_badge.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  late AnimationController _scanController;
  late AnimationController _pulseController;
  late Animation<double> _scanAnimation;
  late Animation<double> _pulseAnimation;

  bool _isScanning = false;
  bool _isProcessing = false;
  bool _showResult = false;

  // Mock scan result data
  final String _detectedWaste = "Plastic Bottle";
  final String _wasteCategory = "Recyclable Plastic";
  final int _earnedPoints = 15;
  final String _recyclingTip =
      "Make sure the bottle is empty and clean before recycling";

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scanController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startScanning() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
      _showResult = false;
    });

    HapticFeedback.lightImpact();
    _scanController.repeat();

    // Simulate AI processing
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isScanning = false;
        _isProcessing = true;
      });

      _scanController.stop();

      // Simulate processing time
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isProcessing = false;
          _showResult = true;
        });

        HapticFeedback.mediumImpact();
      }
    }
  }

  void _resetScan() {
    setState(() {
      _showResult = false;
      _isScanning = false;
      _isProcessing = false;
    });
    _scanController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WasteWiseTheme.primaryText,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview (Mock)
            _buildCameraPreview(),

            // Header
            _buildHeader(),

            // Scan Area
            if (!_showResult) _buildScanArea(),

            // Result Sheet
            if (_showResult) _buildResultSheet(),

            // Bottom Controls
            if (!_showResult) _buildBottomControls(),

            // Processing Overlay
            if (_isProcessing) _buildProcessingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D), Color(0xFF1A1A1A)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 80,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Scan',
              style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Toggle flash
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.flash_off,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: WasteWiseTheme.normalAnimation);
  }

  Widget _buildScanArea() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                color: _isScanning
                    ? WasteWiseTheme.primaryGreen
                    : Colors.white.withOpacity(0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                ..._buildCornerIndicators(),

                if (_isScanning)
                  AnimatedBuilder(
                    animation: _scanAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: (_scanAnimation.value * 250) + 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                WasteWiseTheme.primaryGreen,
                                Colors.transparent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: WasteWiseTheme.primaryGreen.withOpacity(
                                  0.5,
                                ),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),

          const SizedBox(height: WasteWiseTheme.spacing32),

          Text(
            _isScanning
                ? 'Analyzing waste...'
                : 'Point camera at waste\nto identify type',
            style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          if (_isScanning) ...[
            const SizedBox(height: WasteWiseTheme.spacing16),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  WasteWiseTheme.primaryGreen,
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: WasteWiseTheme.normalAnimation);
  }

  List<Widget> _buildCornerIndicators() {
    const double size = 20;
    const double thickness = 3;

    return [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
              left: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
              right: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
              left: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
              right: BorderSide(
                color: WasteWiseTheme.primaryGreen,
                width: thickness,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(WasteWiseTheme.spacing24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: WasteWiseTheme.spacing16,
                vertical: WasteWiseTheme.spacing8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: WasteWiseTheme.accentOrange,
                    size: 16,
                  ),
                  const SizedBox(width: WasteWiseTheme.spacing8),
                  Text(
                    'Pastikan pencahayaan cukup untuk hasil terbaik',
                    style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: WasteWiseTheme.spacing24),

            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isScanning ? _pulseAnimation.value : 1.0,
                  child: GestureDetector(
                    onTap: _startScanning,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            WasteWiseTheme.primaryGreen,
                            WasteWiseTheme.secondaryGreen,
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: WasteWiseTheme.primaryGreen.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isScanning ? Icons.stop : Icons.camera_alt,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: WasteWiseTheme.spacing16),

            TextButton.icon(
              onPressed: () {
                // Open gallery
              },
              icon: const Icon(
                Icons.photo_library,
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                'Pilih dari Galeri',
                style: WasteWiseTheme.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(
      begin: 1,
      end: 0,
      duration: WasteWiseTheme.normalAnimation,
    );
  }

  Widget _buildProcessingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: GlassCard(
          child: Padding(
            padding: const EdgeInsets.all(WasteWiseTheme.spacing24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      WasteWiseTheme.primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(height: WasteWiseTheme.spacing20),
                Text(
                  'AI is analyzing...',
                  style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: WasteWiseTheme.spacing8),
                Text(
                  'Mohon tunggu sebentar',
                  style: WasteWiseTheme.textTheme.bodyMedium?.copyWith(
                    color: WasteWiseTheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: WasteWiseTheme.normalAnimation);
  }

  Widget _buildResultSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: WasteWiseTheme.background,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(WasteWiseTheme.radiusXLarge),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: WasteWiseTheme.spacing12),
              decoration: BoxDecoration(
                color: WasteWiseTheme.tertiaryText,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(WasteWiseTheme.spacing20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: WasteWiseTheme.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: WasteWiseTheme.primaryGreen,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: WasteWiseTheme.spacing16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Teridentifikasi!',
                                style: WasteWiseTheme.textTheme.titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: WasteWiseTheme.primaryGreen,
                                    ),
                              ),
                              Text(
                                'Waste successfully analyzed by AI',
                                style: WasteWiseTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                      color: WasteWiseTheme.secondaryText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        PointsBadge(
                          points: _earnedPoints,
                          showAnimation: true,
                          backgroundColor: WasteWiseTheme.primaryGreen,
                        ),
                      ],
                    ),

                    const SizedBox(height: WasteWiseTheme.spacing24),

                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: WasteWiseTheme.accentBlue.withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.eco,
                                  color: WasteWiseTheme.accentBlue,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: WasteWiseTheme.spacing16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _detectedWaste,
                                      style: WasteWiseTheme
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: WasteWiseTheme.spacing4,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: WasteWiseTheme.spacing8,
                                        vertical: WasteWiseTheme.spacing4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: WasteWiseTheme.primaryGreen
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        _wasteCategory,
                                        style: WasteWiseTheme
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color:
                                                  WasteWiseTheme.primaryGreen,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: WasteWiseTheme.spacing16),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(
                              WasteWiseTheme.spacing12,
                            ),
                            decoration: BoxDecoration(
                              color: WasteWiseTheme.lightGreen.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: WasteWiseTheme.primaryGreen,
                                  size: 16,
                                ),
                                const SizedBox(width: WasteWiseTheme.spacing8),
                                Expanded(
                                  child: Text(
                                    _recyclingTip,
                                    style: WasteWiseTheme.textTheme.bodySmall
                                        ?.copyWith(
                                          color: WasteWiseTheme.primaryGreen,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Expanded(
                          child: GamifiedButton(
                            text: 'Scan Lagi',
                            variant: ButtonVariant.outline,
                            onPressed: _resetScan,
                          ),
                        ),
                        const SizedBox(width: WasteWiseTheme.spacing12),
                        Expanded(
                          child: GamifiedButton(
                            text: 'Add to Recycle Bag',
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
    ).animate().slideY(
      begin: 1,
      end: 0,
      duration: WasteWiseTheme.normalAnimation,
      curve: Curves.easeOutBack,
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    const gridSize = 30.0;

    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
