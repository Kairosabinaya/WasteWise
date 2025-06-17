import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final bool hasBorder;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.hasBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? WasteWiseTheme.glassBackground.withOpacity(0.9),
        borderRadius:
            borderRadius ?? BorderRadius.circular(WasteWiseTheme.radiusLarge),
        border: hasBorder
            ? Border.all(
                color: WasteWiseTheme.glassStroke.withOpacity(0.2),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            borderRadius ?? BorderRadius.circular(WasteWiseTheme.radiusLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: padding ?? const EdgeInsets.all(WasteWiseTheme.spacing16),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: widget);
    }

    return widget;
  }
}
