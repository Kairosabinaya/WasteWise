// Education Models

class EducationLesson {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final int points;
  final bool isCompleted;
  final double progress;
  final String icon;
  final String color;
  final List<String> topics;
  final String? videoUrl;
  final List<QuizQuestion> quiz;

  const EducationLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.points,
    required this.isCompleted,
    required this.progress,
    required this.icon,
    required this.color,
    this.topics = const [],
    this.videoUrl,
    this.quiz = const [],
  });

  factory EducationLesson.fromJson(Map<String, dynamic> json) {
    return EducationLesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      difficulty: json['difficulty'] as String,
      points: json['points'] as int,
      isCompleted: json['isCompleted'] as bool,
      progress: (json['progress'] as num).toDouble(),
      icon: json['icon'] as String,
      color: json['color'] as String,
      topics: (json['topics'] as List<dynamic>?)?.cast<String>() ?? [],
      videoUrl: json['videoUrl'] as String?,
      quiz:
          (json['quiz'] as List<dynamic>?)
              ?.map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'difficulty': difficulty,
      'points': points,
      'isCompleted': isCompleted,
      'progress': progress,
      'icon': icon,
      'color': color,
      'topics': topics,
      'videoUrl': videoUrl,
      'quiz': quiz.map((e) => e.toJson()).toList(),
    };
  }

  EducationLesson copyWith({
    String? id,
    String? title,
    String? description,
    String? duration,
    String? difficulty,
    int? points,
    bool? isCompleted,
    double? progress,
    String? icon,
    String? color,
    List<String>? topics,
    String? videoUrl,
    List<QuizQuestion>? quiz,
  }) {
    return EducationLesson(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      difficulty: difficulty ?? this.difficulty,
      points: points ?? this.points,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      topics: topics ?? this.topics,
      videoUrl: videoUrl ?? this.videoUrl,
      quiz: quiz ?? this.quiz,
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String? explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      correctAnswer: json['correctAnswer'] as int,
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
    };
  }
}

class UserProgress {
  final String userId;
  final String lessonId;
  final double progress;
  final bool isCompleted;
  final int score;
  final DateTime? completedAt;
  final int timeSpentMinutes;

  const UserProgress({
    required this.userId,
    required this.lessonId,
    required this.progress,
    required this.isCompleted,
    required this.score,
    this.completedAt,
    this.timeSpentMinutes = 0,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'] as String,
      lessonId: json['lessonId'] as String,
      progress: (json['progress'] as num).toDouble(),
      isCompleted: json['isCompleted'] as bool,
      score: json['score'] as int,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      timeSpentMinutes: json['timeSpentMinutes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'lessonId': lessonId,
      'progress': progress,
      'isCompleted': isCompleted,
      'score': score,
      'completedAt': completedAt?.toIso8601String(),
      'timeSpentMinutes': timeSpentMinutes,
    };
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int pointsRequired;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final AchievementType type;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.pointsRequired,
    required this.isUnlocked,
    this.unlockedAt,
    required this.type,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      pointsRequired: json['pointsRequired'] as int,
      isUnlocked: json['isUnlocked'] as bool,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'] as String)
          : null,
      type: AchievementType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => AchievementType.education,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'pointsRequired': pointsRequired,
      'isUnlocked': isUnlocked,
      'unlockedAt': unlockedAt?.toIso8601String(),
      'type': type.name,
    };
  }
}

enum AchievementType { education, scanning, recycling, community, marketplace }
