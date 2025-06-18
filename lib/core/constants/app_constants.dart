class AppConstants {
  // App Info
  static const String appName = 'WasteWise';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'AI-powered waste management app with gamification';

  // URLs and Endpoints
  static const String baseUrl = 'https://api.wastewise.com';
  static const String privacyPolicyUrl = 'https://wastewise.com/privacy';
  static const String termsOfServiceUrl = 'https://wastewise.com/terms';

  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String onboardingCompletedKey = 'onboarding_completed';
  static const String pointsKey = 'user_points';
  static const String achievementsKey = 'user_achievements';

  // Animation Durations
  static const int splashDurationMs = 3000;
  static const int quickAnimationMs = 200;
  static const int normalAnimationMs = 300;
  static const int slowAnimationMs = 500;

  // Points System
  static const int scanRewardPoints = 15;
  static const int recycleRewardPoints = 25;
  static const int educationCompletionPoints = 50;
  static const int challengeCompletionPoints = 100;

  // Limits
  static const int maxDailyScans = 10;
  static const int maxFileUploadSizeMB = 5;
  static const int maxCommunityPostLength = 500;

  // Waste Categories
  static const List<String> wasteCategories = [
    'Plastic',
    'Paper',
    'Metal',
    'Organic',
    'Electronic',
    'Hazardous', // Hazardous and Toxic Materials
  ];

  // User Levels
  static const Map<String, int> userLevels = {
    'Beginner': 0,
    'Bronze': 500,
    'Silver': 1500,
    'Gold': 3000,
    'Platinum': 5000,
    'Diamond': 10000,
  };

  // Asset Paths
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';
  static const String animationsPath = 'assets/animations/';
  static const String illustrationsPath = 'assets/illustrations/';

  // Error Messages
  static const String genericErrorMessage =
      'An error occurred. Please try again.';
  static const String networkErrorMessage =
      'Unable to connect to the internet.';
  static const String timeoutErrorMessage =
      'Connection timeout. Please try again.';
  static const String unauthorizedErrorMessage =
      'Your session has expired. Please login again.';

  // Success Messages
  static const String scanSuccessMessage = 'Waste successfully identified!';
  static const String pointsEarnedMessage = 'You earned {points} points!';
  static const String lessonCompletedMessage = 'Lesson completed!';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxUsernameLength = 20;
  static const int minUsernameLength = 3;
}
