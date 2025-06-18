import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/gamified_button.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<CommunityPost> _posts = [
    CommunityPost(
      id: '1',
      author: 'Sarah Green',
      avatar: 'SG',
      timeAgo: '2 hours ago',
      content:
          'Successfully made compost from kitchen waste this week! The results are great and plants are more fertile 🌱',
      imageUrl: 'assets/images/compost.jpg',
      likes: 24,
      comments: 8,
      isLiked: false,
      tags: ['compost', 'organic'],
    ),
    CommunityPost(
      id: '2',
      author: 'Budi Recycler',
      avatar: 'BR',
      timeAgo: '5 hours ago',
      content:
          'Today\'s tip: Used plastic bottles can be turned into unique plant pots! Try it at home 💡',
      imageUrl: null,
      likes: 18,
      comments: 12,
      isLiked: true,
      tags: ['diy', 'plastic'],
    ),
    CommunityPost(
      id: '3',
      author: 'Eco Warrior',
      avatar: 'EW',
      timeAgo: '1 day ago',
      content:
          'This week\'s challenge: Zero waste for 7 days! Who wants to join? 🌍',
      imageUrl: 'assets/images/zero_waste.jpg',
      likes: 45,
      comments: 23,
      isLiked: false,
      tags: ['challenge', 'zerowaste'],
    ),
  ];

  final List<CommunityUser> _leaderboard = [
    CommunityUser(
      name: 'Eco Master',
      points: 3450,
      level: 'Expert',
      avatar: 'EM',
      rank: 1,
    ),
    CommunityUser(
      name: 'Green Ninja',
      points: 2890,
      level: 'Advanced',
      avatar: 'GN',
      rank: 2,
    ),
    CommunityUser(
      name: 'Earth Lover',
      points: 2650,
      level: 'Advanced',
      avatar: 'EL',
      rank: 3,
    ),
    CommunityUser(
      name: 'You',
      points: 2450,
      level: 'Intermediate',
      avatar: 'Y',
      rank: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeedTab(),
                  _buildChallengesTab(),
                  _buildLeaderboardTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePostDialog,
        backgroundColor: WasteWiseTheme.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Community',
                style: WasteWiseTheme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3),
              const SizedBox(height: 4),
              Text(
                    'Share experiences with fellow eco-warriors',
                    style: WasteWiseTheme.textTheme.bodyMedium?.copyWith(
                      color: WasteWiseTheme.secondaryText,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideX(begin: -0.3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: WasteWiseTheme.spacing16),
      child: TabBar(
        controller: _tabController,
        labelColor: WasteWiseTheme.primaryGreen,
        unselectedLabelColor: WasteWiseTheme.secondaryText,
        indicatorColor: WasteWiseTheme.primaryGreen,
        indicatorWeight: 3,
        labelStyle: WasteWiseTheme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Feed'),
          Tab(text: 'Challenges'),
          Tab(text: 'Leaderboard'),
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return _buildPostCard(post, index);
      },
    );
  }

  Widget _buildPostCard(CommunityPost post, int index) {
    return Container(
          margin: const EdgeInsets.only(bottom: WasteWiseTheme.spacing16),
          child: GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: WasteWiseTheme.primaryGreen,
                        child: Text(
                          post.avatar,
                          style: WasteWiseTheme.textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: WasteWiseTheme.spacing12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.author,
                              style: WasteWiseTheme.textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              post.timeAgo,
                              style: WasteWiseTheme.textTheme.bodySmall
                                  ?.copyWith(
                                    color: WasteWiseTheme.secondaryText,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                        color: WasteWiseTheme.secondaryText,
                      ),
                    ],
                  ),
                  const SizedBox(height: WasteWiseTheme.spacing12),
                  // Content
                  Text(
                    post.content,
                    style: WasteWiseTheme.textTheme.bodyMedium,
                  ),
                  if (post.imageUrl != null) ...[
                    const SizedBox(height: WasteWiseTheme.spacing12),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: _getPostImageGradient(post.content),
                        borderRadius: BorderRadius.circular(
                          WasteWiseTheme.radiusLarge,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Background pattern
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  WasteWiseTheme.radiusLarge,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _getPostImageUrl(post.content),
                                  ),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.3),
                                    BlendMode.darken,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Overlay icon
                          Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getPostIcon(post.content),
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: WasteWiseTheme.spacing12),
                  // Tags
                  if (post.tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: post.tags
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: WasteWiseTheme.primaryGreen.withOpacity(
                                  0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '#$tag',
                                style: WasteWiseTheme.textTheme.labelSmall
                                    ?.copyWith(
                                      color: WasteWiseTheme.primaryGreen,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  const SizedBox(height: WasteWiseTheme.spacing12),
                  // Actions
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _toggleLike(post),
                        child: Row(
                          children: [
                            Icon(
                              post.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: post.isLiked
                                  ? WasteWiseTheme.accentRed
                                  : WasteWiseTheme.secondaryText,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              post.likes.toString(),
                              style: WasteWiseTheme.textTheme.bodySmall
                                  ?.copyWith(
                                    color: WasteWiseTheme.secondaryText,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: WasteWiseTheme.spacing24),
                      GestureDetector(
                        onTap: () => _showComments(post),
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              color: WasteWiseTheme.secondaryText,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              post.comments.toString(),
                              style: WasteWiseTheme.textTheme.bodySmall
                                  ?.copyWith(
                                    color: WasteWiseTheme.secondaryText,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => _sharePost(post),
                        child: Icon(
                          Icons.share_outlined,
                          color: WasteWiseTheme.secondaryText,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: (index * 100).ms)
        .slideY(begin: 0.3);
  }

  Widget _buildChallengesTab() {
    return Padding(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Challenge Aktif',
            style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: WasteWiseTheme.spacing16),
          _buildChallengeCard(
            'Zero Waste Week',
            'Live zero waste for 7 days',
            '3 days remaining',
            Icons.eco,
            WasteWiseTheme.primaryGreen,
            0.6,
            150,
          ),
          const SizedBox(height: WasteWiseTheme.spacing16),
          Text(
            'Challenge Mendatang',
            style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: WasteWiseTheme.spacing16),
          _buildChallengeCard(
            'Plastic Free Month',
            'Hindari penggunaan plastik sekali pakai',
            'Dimulai 1 Feb',
            Icons.block,
            WasteWiseTheme.accentBlue,
            0.0,
            300,
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(
    String title,
    String description,
    String timeInfo,
    IconData icon,
    Color color,
    double progress,
    int points,
  ) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      WasteWiseTheme.radiusLarge,
                    ),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: WasteWiseTheme.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        description,
                        style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                          color: WasteWiseTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$points pts',
                      style: WasteWiseTheme.textTheme.titleSmall?.copyWith(
                        color: WasteWiseTheme.goldStar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeInfo,
                      style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                        color: WasteWiseTheme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (progress > 0) ...[
              const SizedBox(height: WasteWiseTheme.spacing12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: WasteWiseTheme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: WasteWiseTheme.textTheme.labelMedium?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: WasteWiseTheme.glassStroke,
                    valueColor: AlwaysStoppedAnimation(color),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ],
            const SizedBox(height: WasteWiseTheme.spacing12),
            GamifiedButton(
              text: progress > 0 ? 'Lanjutkan' : 'Ikut Challenge',
              onPressed: () {},
              variant: ButtonVariant.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardTab() {
    return Padding(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Eco-Warriors',
            style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: WasteWiseTheme.spacing16),
          Expanded(
            child: ListView.builder(
              itemCount: _leaderboard.length,
              itemBuilder: (context, index) {
                final user = _leaderboard[index];
                return _buildLeaderboardItem(user, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(CommunityUser user, int index) {
    final isCurrentUser = user.name == 'You';

    return Container(
          margin: const EdgeInsets.only(bottom: WasteWiseTheme.spacing12),
          child: GlassCard(
            child: Container(
              decoration: isCurrentUser
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        WasteWiseTheme.radiusLarge,
                      ),
                      border: Border.all(
                        color: WasteWiseTheme.primaryGreen,
                        width: 2,
                      ),
                    )
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
                child: Row(
                  children: [
                    // Rank
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getRankColor(user.rank).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '#${user.rank}',
                          style: WasteWiseTheme.textTheme.titleSmall?.copyWith(
                            color: _getRankColor(user.rank),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: WasteWiseTheme.spacing12),
                    // Avatar
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: isCurrentUser
                          ? WasteWiseTheme.primaryGreen
                          : WasteWiseTheme.accentBlue,
                      child: Text(
                        user.avatar,
                        style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: WasteWiseTheme.spacing12),
                    // User info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: WasteWiseTheme.textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isCurrentUser
                                      ? WasteWiseTheme.primaryGreen
                                      : null,
                                ),
                          ),
                          Text(
                            user.level,
                            style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                              color: WasteWiseTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Points
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${user.points}',
                          style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: WasteWiseTheme.goldStar,
                          ),
                        ),
                        Text(
                          'poin',
                          style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                            color: WasteWiseTheme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: (index * 100).ms)
        .slideX(begin: 0.3);
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return WasteWiseTheme.goldStar;
      case 2:
        return WasteWiseTheme.silverStar;
      case 3:
        return WasteWiseTheme.bronzeStar;
      default:
        return WasteWiseTheme.primaryGreen;
    }
  }

  void _toggleLike(CommunityPost post) {
    setState(() {
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
    });
  }

  void _showComments(CommunityPost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Komentar untuk post ${post.author}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _sharePost(CommunityPost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berbagi post ${post.author}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WasteWiseTheme.radiusLarge),
        ),
        title: Text(
          'Buat Post Baru',
          style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Bagikan pengalaman eco-friendly Anda...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    WasteWiseTheme.radiusLarge,
                  ),
                ),
              ),
            ),
            const SizedBox(height: WasteWiseTheme.spacing16),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.image),
                  tooltip: 'Add photo',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tag),
                  tooltip: 'Add tag',
                ),
              ],
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
            text: 'Post',
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Post successfully shared!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            variant: ButtonVariant.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            fontSize: 14,
          ),
        ],
      ),
    );
  }

  LinearGradient _getPostImageGradient(String content) {
    if (content.toLowerCase().contains('compost')) {
      return LinearGradient(
        colors: [
          WasteWiseTheme.primaryGreen,
          WasteWiseTheme.primaryGreen.withOpacity(0.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (content.toLowerCase().contains('zero waste')) {
      return LinearGradient(
        colors: [
          WasteWiseTheme.accentBlue,
          WasteWiseTheme.accentBlue.withOpacity(0.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
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

  IconData _getPostIcon(String content) {
    if (content.toLowerCase().contains('compost')) {
      return Icons.compost;
    } else if (content.toLowerCase().contains('zero waste')) {
      return Icons.eco;
    } else if (content.toLowerCase().contains('recycle')) {
      return Icons.recycling;
    } else if (content.toLowerCase().contains('plastic')) {
      return Icons.block;
    } else {
      return Icons.nature;
    }
  }

  String _getPostImageUrl(String content) {
    if (content.toLowerCase().contains('compost')) {
      return 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400&h=200&fit=crop&crop=center';
    } else if (content.toLowerCase().contains('zero waste')) {
      return 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=200&fit=crop&crop=center';
    } else if (content.toLowerCase().contains('recycle')) {
      return 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=400&h=200&fit=crop&crop=center';
    } else {
      return 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400&h=200&fit=crop&crop=center';
    }
  }
}

class CommunityPost {
  final String id;
  final String author;
  final String avatar;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final bool isLiked;
  final List<String> tags;

  CommunityPost({
    required this.id,
    required this.author,
    required this.avatar,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.isLiked,
    required this.tags,
  });

  CommunityPost copyWith({
    String? id,
    String? author,
    String? avatar,
    String? timeAgo,
    String? content,
    String? imageUrl,
    int? likes,
    int? comments,
    bool? isLiked,
    List<String>? tags,
  }) {
    return CommunityPost(
      id: id ?? this.id,
      author: author ?? this.author,
      avatar: avatar ?? this.avatar,
      timeAgo: timeAgo ?? this.timeAgo,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
      tags: tags ?? this.tags,
    );
  }
}

class CommunityUser {
  final String name;
  final int points;
  final String level;
  final String avatar;
  final int rank;

  CommunityUser({
    required this.name,
    required this.points,
    required this.level,
    required this.avatar,
    required this.rank,
  });
}
