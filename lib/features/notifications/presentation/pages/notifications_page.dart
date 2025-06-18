import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/custom_bottom_navigation.dart';
import 'package:wastewise/features/scan/presentation/pages/scan_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Using same color palette as home_page.dart
  static const Color _backgroundColor = Color(0xFFF8FAFC);
  static const Color _primaryGreen = Color(0xFF10B981);
  static const Color _lightGreen = Color(0xFFECFDF5);
  static const Color _textPrimary = Color(0xFF1F2937);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _surfaceWhite = Color(0xFFFFFFFF);
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

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Points Earned!',
      'message': 'You earned 25 points for recycling plastic bottles',
      'time': '2 minutes ago',
      'isRead': false,
      'type': 'points',
      'icon': LucideIcons.star,
      'color': _rewardPurple,
    },
    {
      'id': '2',
      'title': 'New Achievement Unlocked!',
      'message': 'Congratulations! You\'ve unlocked "Eco Pioneer" achievement',
      'time': '1 hour ago',
      'isRead': false,
      'type': 'achievement',
      'icon': LucideIcons.award,
      'color': _hazardOrange,
    },
    {
      'id': '3',
      'title': 'Smart Bin Found',
      'message': 'A smart bin is available 200m from your location',
      'time': '3 hours ago',
      'isRead': true,
      'type': 'location',
      'icon': LucideIcons.mapPin,
      'color': _recycleBlue,
    },
    {
      'id': '4',
      'title': 'Weekly Challenge',
      'message': 'New weekly challenge: Recycle 10 items this week',
      'time': 'Yesterday',
      'isRead': true,
      'type': 'challenge',
      'icon': LucideIcons.target,
      'color': _primaryGreen,
    },
    {
      'id': '5',
      'title': 'Community Update',
      'message': 'Sarah Green liked your recycling post',
      'time': '2 days ago',
      'isRead': true,
      'type': 'social',
      'icon': LucideIcons.heart,
      'color': _statCoral,
    },
  ];

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
              _buildHeader(),
              Expanded(child: _buildNotificationsList()),
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
          const Expanded(child: Text('Notifications', style: _headingStyle)),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _markAllAsRead();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _primaryGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final unreadCount = _notifications.where((n) => !n['isRead']).length;

    return FadeInDown(
      duration: const Duration(milliseconds: 700),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_primaryGreen, _primaryGreen.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: _primaryGreen.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.bell,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$unreadCount new notifications',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Stay updated with your eco activities',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _buildNotificationItem(notification, index),
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    final isRead = notification['isRead'] as bool;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _markAsRead(index);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRead ? _surfaceWhite : _lightGreen.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isRead ? Colors.transparent : _primaryGreen.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isRead ? 0.04 : 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    notification['color'] as Color,
                    (notification['color'] as Color).withOpacity(0.8),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                notification['icon'] as IconData,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'] as String,
                          style: _subheadingStyle.copyWith(
                            fontWeight: isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: _primaryGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['message'] as String,
                    style: _captionStyle.copyWith(
                      color: isRead ? _textSecondary : _textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification['time'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: _textSecondary.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                _deleteNotification(index);
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _textSecondary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.x, color: _textSecondary, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }
}
