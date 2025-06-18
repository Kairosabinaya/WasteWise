import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final String? category;
  final String? name;
  final IconData? icon;
  final BorderRadius? borderRadius;
  final bool showIcon;
  final Color? backgroundColor;

  const ImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.category,
    this.name,
    this.icon,
    this.borderRadius,
    this.showIcon = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: showIcon
          ? Center(
              child: Container(
                width: (width != null && width! < 100) ? width! * 0.4 : 40,
                height: (height != null && height! < 100) ? height! * 0.4 : 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon(),
                  size: (width != null && width! < 100) ? width! * 0.2 : 24,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }

  LinearGradient _getGradient() {
    if (backgroundColor != null) {
      return LinearGradient(
        colors: [backgroundColor!, backgroundColor!.withOpacity(0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    // Category-based gradients
    if (category != null) {
      switch (category!.toLowerCase()) {
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
        case 'food':
        case 'organic':
          return LinearGradient(
            colors: [
              WasteWiseTheme.primaryGreen,
              WasteWiseTheme.primaryGreen.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
        case 'recyclable':
          return LinearGradient(
            colors: [
              WasteWiseTheme.accentBlue,
              WasteWiseTheme.accentBlue.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
        case 'hazardous':
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

    // Name-based gradients
    if (name != null) {
      final lowerName = name!.toLowerCase();
      if (lowerName.contains('bottle') || lowerName.contains('water')) {
        return LinearGradient(
          colors: [
            WasteWiseTheme.accentBlue,
            WasteWiseTheme.accentBlue.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      } else if (lowerName.contains('compost') ||
          lowerName.contains('organic')) {
        return LinearGradient(
          colors: [
            WasteWiseTheme.primaryGreen,
            WasteWiseTheme.primaryGreen.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      } else if (lowerName.contains('zero waste') ||
          lowerName.contains('eco')) {
        return LinearGradient(
          colors: [
            WasteWiseTheme.primaryGreen,
            WasteWiseTheme.primaryGreen.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      }
    }

    // Default gradient
    return LinearGradient(
      colors: [
        WasteWiseTheme.accentOrange,
        WasteWiseTheme.accentOrange.withOpacity(0.7),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  IconData _getIcon() {
    if (icon != null) return icon!;

    // Name-based icons
    if (name != null) {
      final lowerName = name!.toLowerCase();
      if (lowerName.contains('bottle')) return Icons.water_drop;
      if (lowerName.contains('shirt') || lowerName.contains('cotton'))
        return Icons.checkroom;
      if (lowerName.contains('power') || lowerName.contains('solar'))
        return Icons.battery_charging_full;
      if (lowerName.contains('lunch') || lowerName.contains('bamboo'))
        return Icons.lunch_dining;
      if (lowerName.contains('compost')) return Icons.compost;
      if (lowerName.contains('zero waste')) return Icons.eco;
      if (lowerName.contains('recycle')) return Icons.recycling;
      if (lowerName.contains('plastic')) return Icons.block;
    }

    // Category-based icons
    if (category != null) {
      switch (category!.toLowerCase()) {
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
        case 'food':
        case 'organic':
          return Icons.eco;
        case 'recyclable':
          return Icons.recycling;
        case 'hazardous':
          return Icons.warning;
        case 'residual':
          return Icons.delete;
      }
    }

    return Icons.image;
  }
}

// Network image with fallback placeholder
class NetworkImageWithPlaceholder extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? category;
  final String? name;
  final BorderRadius? borderRadius;

  const NetworkImageWithPlaceholder({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.category,
    this.name,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return ImagePlaceholder(
            width: width,
            height: height,
            category: category,
            name: name,
            borderRadius: borderRadius,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return ImagePlaceholder(
            width: width,
            height: height,
            category: category,
            name: name,
            borderRadius: borderRadius,
            showIcon: false,
            backgroundColor: Colors.grey.withOpacity(0.3),
          );
        },
      ),
    );
  }
}
