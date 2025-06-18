// Community Models

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
  final DateTime createdAt;
  final List<Comment> commentsList;

  const CommunityPost({
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
    required this.createdAt,
    this.commentsList = const [],
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      id: json['id'] as String,
      author: json['author'] as String,
      avatar: json['avatar'] as String,
      timeAgo: json['timeAgo'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      likes: json['likes'] as int,
      comments: json['comments'] as int,
      isLiked: json['isLiked'] as bool,
      tags: (json['tags'] as List<dynamic>).cast<String>(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      commentsList:
          (json['commentsList'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'avatar': avatar,
      'timeAgo': timeAgo,
      'content': content,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
      'isLiked': isLiked,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'commentsList': commentsList.map((e) => e.toJson()).toList(),
    };
  }

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
    DateTime? createdAt,
    List<Comment>? commentsList,
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
      createdAt: createdAt ?? this.createdAt,
      commentsList: commentsList ?? this.commentsList,
    );
  }
}

class Comment {
  final String id;
  final String author;
  final String avatar;
  final String content;
  final DateTime createdAt;
  final int likes;
  final bool isLiked;

  const Comment({
    required this.id,
    required this.author,
    required this.avatar,
    required this.content,
    required this.createdAt,
    this.likes = 0,
    this.isLiked = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      author: json['author'] as String,
      avatar: json['avatar'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likes: json['likes'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'avatar': avatar,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
      'isLiked': isLiked,
    };
  }
}

class CommunityUser {
  final String name;
  final int points;
  final String level;
  final String avatar;
  final int rank;
  final String? bio;
  final List<String> achievements;
  final DateTime joinedAt;
  final CommunityStats stats;

  const CommunityUser({
    required this.name,
    required this.points,
    required this.level,
    required this.avatar,
    required this.rank,
    this.bio,
    this.achievements = const [],
    required this.joinedAt,
    required this.stats,
  });

  factory CommunityUser.fromJson(Map<String, dynamic> json) {
    return CommunityUser(
      name: json['name'] as String,
      points: json['points'] as int,
      level: json['level'] as String,
      avatar: json['avatar'] as String,
      rank: json['rank'] as int,
      bio: json['bio'] as String?,
      achievements:
          (json['achievements'] as List<dynamic>?)?.cast<String>() ?? [],
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      stats: CommunityStats.fromJson(json['stats'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'points': points,
      'level': level,
      'avatar': avatar,
      'rank': rank,
      'bio': bio,
      'achievements': achievements,
      'joinedAt': joinedAt.toIso8601String(),
      'stats': stats.toJson(),
    };
  }
}

class CommunityStats {
  final int postsCount;
  final int likesReceived;
  final int commentsCount;
  final int challengesCompleted;
  final int recycledItems;

  const CommunityStats({
    required this.postsCount,
    required this.likesReceived,
    required this.commentsCount,
    required this.challengesCompleted,
    required this.recycledItems,
  });

  factory CommunityStats.fromJson(Map<String, dynamic> json) {
    return CommunityStats(
      postsCount: json['postsCount'] as int,
      likesReceived: json['likesReceived'] as int,
      commentsCount: json['commentsCount'] as int,
      challengesCompleted: json['challengesCompleted'] as int,
      recycledItems: json['recycledItems'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postsCount': postsCount,
      'likesReceived': likesReceived,
      'commentsCount': commentsCount,
      'challengesCompleted': challengesCompleted,
      'recycledItems': recycledItems,
    };
  }
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int points;
  final DateTime startDate;
  final DateTime endDate;
  final ChallengeType type;
  final int participantsCount;
  final bool isActive;
  final bool isCompleted;
  final double progress;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.points,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.participantsCount,
    required this.isActive,
    required this.isCompleted,
    required this.progress,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      points: json['points'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      type: ChallengeType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ChallengeType.weekly,
      ),
      participantsCount: json['participantsCount'] as int,
      isActive: json['isActive'] as bool,
      isCompleted: json['isCompleted'] as bool,
      progress: (json['progress'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'points': points,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'type': type.name,
      'participantsCount': participantsCount,
      'isActive': isActive,
      'isCompleted': isCompleted,
      'progress': progress,
    };
  }
}

enum ChallengeType { daily, weekly, monthly, special }
