import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wastewise/core/theme/app_theme.dart';
import 'package:wastewise/shared/widgets/glass_card.dart';
import 'package:wastewise/shared/widgets/gamified_button.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final PageController _pageController = PageController();
  int _currentLessonIndex = 0;

  final List<EducationLesson> _lessons = [
    EducationLesson(
      id: '1',
      title: 'Dasar-dasar Pengelolaan Sampah',
      description: 'Pelajari konsep dasar 3R: Reduce, Reuse, Recycle',
      duration: '10 menit',
      difficulty: 'Pemula',
      points: 50,
      isCompleted: true,
      progress: 1.0,
      icon: Icons.school,
      color: WasteWiseTheme.primaryGreen,
    ),
    EducationLesson(
      id: '2',
      title: 'Pemilahan Sampah yang Benar',
      description: 'Cara memilah sampah organik dan anorganik dengan tepat',
      duration: '15 menit',
      difficulty: 'Pemula',
      points: 75,
      isCompleted: true,
      progress: 1.0,
      icon: Icons.sort,
      color: WasteWiseTheme.accentBlue,
    ),
    EducationLesson(
      id: '3',
      title: 'Kompos dari Sampah Organik',
      description: 'Membuat kompos berkualitas dari sampah dapur',
      duration: '20 menit',
      difficulty: 'Menengah',
      points: 100,
      isCompleted: false,
      progress: 0.6,
      icon: Icons.grass,
      color: WasteWiseTheme.darkGreen,
    ),
    EducationLesson(
      id: '4',
      title: 'Daur Ulang Kreatif',
      description: 'Mengubah sampah menjadi barang berguna dan bernilai',
      duration: '25 menit',
      difficulty: 'Menengah',
      points: 125,
      isCompleted: false,
      progress: 0.2,
      icon: Icons.recycling,
      color: WasteWiseTheme.accentPurple,
    ),
    EducationLesson(
      id: '5',
      title: 'Zero Waste Lifestyle',
      description:
          'Menerapkan gaya hidup tanpa sampah dalam kehidupan sehari-hari',
      duration: '30 menit',
      difficulty: 'Lanjutan',
      points: 150,
      isCompleted: false,
      progress: 0.0,
      icon: Icons.eco,
      color: WasteWiseTheme.accentOrange,
    ),
  ];

  final List<QuizQuestion> _currentQuiz = [
    QuizQuestion(
      question: 'Apa yang dimaksud dengan 3R dalam pengelolaan sampah?',
      options: [
        'Reduce, Reuse, Recycle',
        'Remove, Reduce, Recycle',
        'Reduce, Repair, Recycle',
        'Reuse, Repair, Remove',
      ],
      correctAnswer: 0,
    ),
    QuizQuestion(
      question: 'Sampah organik yang paling mudah dikompos adalah?',
      options: [
        'Kulit buah dan sayuran',
        'Tulang ayam',
        'Daun kering',
        'Semua benar',
      ],
      correctAnswer: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WasteWiseTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressOverview(),
            Expanded(child: _buildLessonsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edukasi Lingkungan',
            style: WasteWiseTheme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3),
          const SizedBox(height: 4),
          Text(
                'Pelajari cara mengelola sampah dengan benar',
                style: WasteWiseTheme.textTheme.bodyMedium?.copyWith(
                  color: WasteWiseTheme.secondaryText,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .slideX(begin: -0.3),
        ],
      ),
    );
  }

  Widget _buildProgressOverview() {
    final completedLessons = _lessons
        .where((lesson) => lesson.isCompleted)
        .length;
    final totalPoints = _lessons
        .where((lesson) => lesson.isCompleted)
        .fold(0, (sum, lesson) => sum + lesson.points);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: WasteWiseTheme.spacing16),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
          child: Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Pelajaran Selesai',
                  '$completedLessons/${_lessons.length}',
                  Icons.book,
                  WasteWiseTheme.primaryGreen,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: WasteWiseTheme.glassStroke,
              ),
              Expanded(
                child: _buildStatItem(
                  'Total Poin',
                  totalPoints.toString(),
                  Icons.stars,
                  WasteWiseTheme.goldStar,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: WasteWiseTheme.glassStroke,
              ),
              Expanded(
                child: _buildStatItem(
                  'Tingkat',
                  _getUserLevel(totalPoints),
                  Icons.emoji_events,
                  WasteWiseTheme.accentOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.3);
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: WasteWiseTheme.textTheme.labelSmall?.copyWith(
            color: WasteWiseTheme.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _getUserLevel(int points) {
    if (points >= 400) return 'Expert';
    if (points >= 200) return 'Advanced';
    if (points >= 100) return 'Intermediate';
    return 'Beginner';
  }

  Widget _buildLessonsList() {
    return Padding(
      padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
      child: ListView.builder(
        itemCount: _lessons.length,
        itemBuilder: (context, index) {
          final lesson = _lessons[index];
          return _buildLessonCard(lesson, index);
        },
      ),
    );
  }

  Widget _buildLessonCard(EducationLesson lesson, int index) {
    return Container(
          margin: const EdgeInsets.only(bottom: WasteWiseTheme.spacing16),
          child: GlassCard(
            child: InkWell(
              onTap: () => _openLesson(lesson),
              borderRadius: BorderRadius.circular(WasteWiseTheme.radiusLarge),
              child: Padding(
                padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
                child: Row(
                  children: [
                    // Lesson Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: lesson.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          WasteWiseTheme.radiusLarge,
                        ),
                      ),
                      child: Icon(lesson.icon, color: lesson.color, size: 28),
                    ),
                    const SizedBox(width: WasteWiseTheme.spacing16),
                    // Lesson Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  lesson.title,
                                  style: WasteWiseTheme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              if (lesson.isCompleted)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: WasteWiseTheme.primaryGreen,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Selesai',
                                        style: WasteWiseTheme
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lesson.description,
                            style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                              color: WasteWiseTheme.secondaryText,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: WasteWiseTheme.secondaryText,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lesson.duration,
                                style: WasteWiseTheme.textTheme.labelSmall
                                    ?.copyWith(
                                      color: WasteWiseTheme.secondaryText,
                                    ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.signal_cellular_alt,
                                size: 14,
                                color: WasteWiseTheme.secondaryText,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lesson.difficulty,
                                style: WasteWiseTheme.textTheme.labelSmall
                                    ?.copyWith(
                                      color: WasteWiseTheme.secondaryText,
                                    ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.stars,
                                size: 14,
                                color: WasteWiseTheme.goldStar,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${lesson.points} pts',
                                style: WasteWiseTheme.textTheme.labelSmall
                                    ?.copyWith(
                                      color: WasteWiseTheme.goldStar,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          if (!lesson.isCompleted && lesson.progress > 0) ...[
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Progress',
                                      style: WasteWiseTheme.textTheme.labelSmall
                                          ?.copyWith(
                                            color: WasteWiseTheme.secondaryText,
                                          ),
                                    ),
                                    Text(
                                      '${(lesson.progress * 100).toInt()}%',
                                      style: WasteWiseTheme.textTheme.labelSmall
                                          ?.copyWith(
                                            color: WasteWiseTheme.primaryGreen,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                LinearProgressIndicator(
                                  value: lesson.progress,
                                  backgroundColor: WasteWiseTheme.glassStroke,
                                  valueColor: AlwaysStoppedAnimation(
                                    lesson.color,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
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

  void _openLesson(EducationLesson lesson) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildLessonModal(lesson),
    );
  }

  Widget _buildLessonModal(EducationLesson lesson) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: WasteWiseTheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(WasteWiseTheme.radiusXLarge),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: WasteWiseTheme.glassStroke,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: lesson.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      WasteWiseTheme.radiusLarge,
                    ),
                  ),
                  child: Icon(lesson.icon, color: lesson.color, size: 24),
                ),
                const SizedBox(width: WasteWiseTheme.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: WasteWiseTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${lesson.duration} • ${lesson.difficulty} • ${lesson.points} pts',
                        style: WasteWiseTheme.textTheme.bodySmall?.copyWith(
                          color: WasteWiseTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: WasteWiseTheme.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.description,
                    style: WasteWiseTheme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: WasteWiseTheme.spacing24),
                  if (!lesson.isCompleted) ...[
                    GamifiedButton(
                      text: lesson.progress > 0
                          ? 'Lanjutkan Pelajaran'
                          : 'Mulai Pelajaran',
                      onPressed: () {
                        Navigator.of(context).pop();
                        _startQuiz(lesson);
                      },
                      variant: ButtonVariant.primary,
                      icon: lesson.progress > 0
                          ? Icons.play_arrow
                          : Icons.start,
                    ),
                  ] else ...[
                    GamifiedButton(
                      text: 'Ulangi Pelajaran',
                      onPressed: () {
                        Navigator.of(context).pop();
                        _startQuiz(lesson);
                      },
                      variant: ButtonVariant.secondary,
                      icon: Icons.replay,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startQuiz(EducationLesson lesson) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _QuizDialog(
        questions: _currentQuiz,
        onCompleted: (score) {
          _completeLesson(lesson, score);
        },
      ),
    );
  }

  void _completeLesson(EducationLesson lesson, int score) {
    setState(() {
      final index = _lessons.indexWhere((l) => l.id == lesson.id);
      if (index != -1) {
        _lessons[index] = lesson.copyWith(isCompleted: true, progress: 1.0);
      }
    });

    // Show completion animation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: WasteWiseTheme.primaryGreen,
        content: Row(
          children: [
            const Icon(Icons.celebration, color: Colors.white),
            const SizedBox(width: WasteWiseTheme.spacing8),
            Expanded(
              child: Text(
                'Selamat! Anda telah menyelesaikan "${lesson.title}" dan mendapat ${lesson.points} poin!',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WasteWiseTheme.radiusLarge),
        ),
      ),
    );
  }
}

class _QuizDialog extends StatefulWidget {
  final List<QuizQuestion> questions;
  final Function(int score) onCompleted;

  const _QuizDialog({required this.questions, required this.onCompleted});

  @override
  State<_QuizDialog> createState() => _QuizDialogState();
}

class _QuizDialogState extends State<_QuizDialog> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WasteWiseTheme.radiusXLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.all(WasteWiseTheme.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pertanyaan ${_currentQuestionIndex + 1}/${widget.questions.length}',
              style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                color: WasteWiseTheme.primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: WasteWiseTheme.spacing16),
            Text(
              question.question,
              style: WasteWiseTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: WasteWiseTheme.spacing20),
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = _selectedAnswer == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: _showResult
                      ? null
                      : () {
                          setState(() {
                            _selectedAnswer = index;
                          });
                        },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(WasteWiseTheme.spacing16),
                    decoration: BoxDecoration(
                      color: _showResult
                          ? (index == question.correctAnswer
                                ? WasteWiseTheme.primaryGreen.withOpacity(0.1)
                                : (isSelected
                                      ? WasteWiseTheme.accentRed.withOpacity(
                                          0.1,
                                        )
                                      : null))
                          : (isSelected
                                ? WasteWiseTheme.primaryGreen.withOpacity(0.1)
                                : null),
                      border: Border.all(
                        color: _showResult
                            ? (index == question.correctAnswer
                                  ? WasteWiseTheme.primaryGreen
                                  : (isSelected
                                        ? WasteWiseTheme.accentRed
                                        : WasteWiseTheme.glassStroke))
                            : (isSelected
                                  ? WasteWiseTheme.primaryGreen
                                  : WasteWiseTheme.glassStroke),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                        WasteWiseTheme.radiusLarge,
                      ),
                    ),
                    child: Text(
                      option,
                      style: WasteWiseTheme.textTheme.bodyMedium?.copyWith(
                        color: _showResult
                            ? (index == question.correctAnswer
                                  ? WasteWiseTheme.primaryGreen
                                  : (isSelected
                                        ? WasteWiseTheme.accentRed
                                        : WasteWiseTheme.primaryText))
                            : (isSelected
                                  ? WasteWiseTheme.primaryGreen
                                  : WasteWiseTheme.primaryText),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: WasteWiseTheme.spacing20),
            if (!_showResult)
              GamifiedButton(
                text: 'Jawab',
                onPressed: _selectedAnswer != null ? _checkAnswer : null,
                variant: _selectedAnswer != null
                    ? ButtonVariant.primary
                    : ButtonVariant.ghost,
              )
            else
              GamifiedButton(
                text: _currentQuestionIndex < widget.questions.length - 1
                    ? 'Lanjut'
                    : 'Selesai',
                onPressed: _nextQuestion,
                variant: ButtonVariant.primary,
              ),
          ],
        ),
      ),
    );
  }

  void _checkAnswer() {
    setState(() {
      _showResult = true;
      if (_selectedAnswer ==
          widget.questions[_currentQuestionIndex].correctAnswer) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _showResult = false;
      });
    } else {
      Navigator.of(context).pop();
      widget.onCompleted(_score);
    }
  }
}

class EducationLesson {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final int points;
  final bool isCompleted;
  final double progress;
  final IconData icon;
  final Color color;

  EducationLesson({
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
  });

  EducationLesson copyWith({
    String? id,
    String? title,
    String? description,
    String? duration,
    String? difficulty,
    int? points,
    bool? isCompleted,
    double? progress,
    IconData? icon,
    Color? color,
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
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
