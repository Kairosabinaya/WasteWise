import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

enum ButtonVariant { primary, secondary, outline, ghost }

class GamifiedButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsets? padding;
  final double? fontSize;

  const GamifiedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
    this.fontSize,
  });

  @override
  State<GamifiedButton> createState() => _GamifiedButtonState();
}

class _GamifiedButtonState extends State<GamifiedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: WasteWiseTheme.quickAnimation,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
      _animationController.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _handleTapCancel();
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  Color _getBackgroundColor() {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return WasteWiseTheme.primaryGreen;
      case ButtonVariant.secondary:
        return WasteWiseTheme.secondaryGreen;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.ghost:
        return WasteWiseTheme.lightGreen;
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return Colors.white;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
        return WasteWiseTheme.primaryGreen;
    }
  }

  Border? _getBorder() {
    if (widget.variant == ButtonVariant.outline) {
      return Border.all(color: WasteWiseTheme.primaryGreen, width: 2);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.onPressed,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: widget.isFullWidth ? double.infinity : null,
                  padding:
                      widget.padding ??
                      const EdgeInsets.symmetric(
                        horizontal: WasteWiseTheme.spacing24,
                        vertical: WasteWiseTheme.spacing16,
                      ),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(),
                    borderRadius: BorderRadius.circular(
                      WasteWiseTheme.radiusMedium,
                    ),
                    border: _getBorder(),
                    boxShadow:
                        widget.variant == ButtonVariant.primary ||
                            widget.variant == ButtonVariant.secondary
                        ? [
                            BoxShadow(
                              color: _getBackgroundColor().withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isLoading)
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getTextColor(),
                            ),
                          ),
                        )
                      else if (widget.icon != null)
                        Icon(widget.icon, color: _getTextColor(), size: 18),
                      if (widget.icon != null && !widget.isLoading)
                        const SizedBox(width: WasteWiseTheme.spacing8),
                      if (!widget.isLoading)
                        Text(
                          widget.text,
                          style: WasteWiseTheme.textTheme.labelLarge?.copyWith(
                            color: _getTextColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: widget.fontSize,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
        .animate(target: _isPressed ? 1 : 0)
        .shimmer(
          duration: const Duration(milliseconds: 1000),
          color: Colors.white.withOpacity(0.3),
        );
  }
}
