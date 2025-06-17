import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class PointsBadge extends StatefulWidget {
  final int points;
  final bool showAnimation;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const PointsBadge({
    super.key,
    required this.points,
    this.showAnimation = false,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  State<PointsBadge> createState() => _PointsBadgeState();
}

class _PointsBadgeState extends State<PointsBadge> {
  late int _displayedPoints;
  late int _previousPoints;

  @override
  void initState() {
    super.initState();
    _displayedPoints = widget.points;
    _previousPoints = widget.points;
  }

  @override
  void didUpdateWidget(PointsBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.points != widget.points) {
      _previousPoints = _displayedPoints;
      _displayedPoints = widget.points;
    }
  }

  String _formatPoints(int points) {
    if (points >= 1000000) {
      return '${(points / 1000000).toStringAsFixed(1)}M';
    } else if (points >= 1000) {
      return '${(points / 1000).toStringAsFixed(1)}K';
    }
    return points.toString();
  }

  @override
  Widget build(BuildContext context) {
    Widget badge = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WasteWiseTheme.spacing16,
        vertical: WasteWiseTheme.spacing8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.backgroundColor ?? WasteWiseTheme.primaryGreen,
            widget.backgroundColor?.withOpacity(0.8) ??
                WasteWiseTheme.secondaryGreen,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (widget.backgroundColor ?? WasteWiseTheme.primaryGreen)
                .withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon ?? Icons.eco,
            color: widget.textColor ?? Colors.white,
            size: 16,
          ),
          const SizedBox(width: WasteWiseTheme.spacing4),
          AnimatedSwitcher(
            duration: WasteWiseTheme.normalAnimation,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Text(
              _formatPoints(_displayedPoints),
              key: ValueKey(_displayedPoints),
              style: WasteWiseTheme.textTheme.labelMedium?.copyWith(
                color: widget.textColor ?? Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: WasteWiseTheme.spacing4),
          Text(
            'PTS',
            style: WasteWiseTheme.textTheme.labelSmall?.copyWith(
              color: (widget.textColor ?? Colors.white).withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    // Add tap functionality if provided
    if (widget.onTap != null) {
      badge = GestureDetector(onTap: widget.onTap, child: badge);
    }

    // Add animation if points increased
    if (widget.showAnimation && _displayedPoints > _previousPoints) {
      badge = badge
          .animate()
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.2, 1.2),
            duration: const Duration(milliseconds: 200),
            curve: Curves.elasticOut,
          )
          .then()
          .scale(
            begin: const Offset(1.2, 1.2),
            end: const Offset(1.0, 1.0),
            duration: const Duration(milliseconds: 200),
            curve: Curves.elasticOut,
          )
          .shimmer(
            duration: const Duration(milliseconds: 1000),
            color: Colors.white.withOpacity(0.5),
          );
    }

    return badge;
  }
}

class PointsDelta extends StatelessWidget {
  final int deltaPoints;
  final bool isPositive;

  const PointsDelta({
    super.key,
    required this.deltaPoints,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: WasteWiseTheme.spacing12,
            vertical: WasteWiseTheme.spacing4,
          ),
          decoration: BoxDecoration(
            color: isPositive
                ? WasteWiseTheme.primaryGreen.withOpacity(0.1)
                : WasteWiseTheme.accentRed.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPositive
                  ? WasteWiseTheme.primaryGreen.withOpacity(0.3)
                  : WasteWiseTheme.accentRed.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPositive ? Icons.add : Icons.remove,
                color: isPositive
                    ? WasteWiseTheme.primaryGreen
                    : WasteWiseTheme.accentRed,
                size: 12,
              ),
              const SizedBox(width: WasteWiseTheme.spacing4),
              Text(
                '$deltaPoints pts',
                style: WasteWiseTheme.textTheme.labelSmall?.copyWith(
                  color: isPositive
                      ? WasteWiseTheme.primaryGreen
                      : WasteWiseTheme.accentRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
        .animate()
        .slideY(
          begin: -1,
          end: 0,
          duration: WasteWiseTheme.normalAnimation,
          curve: Curves.bounceOut,
        )
        .fadeIn(duration: WasteWiseTheme.normalAnimation);
  }
}
