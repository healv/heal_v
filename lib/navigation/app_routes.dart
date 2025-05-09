abstract final class AppRoutes {
  /// Launch route
  static const String launch = '/launch';
}

abstract final class AuthRoutes {
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String permission = '/permission';
}

abstract final class MainRoutes {
  static const String home = '/mainHome';
  static const String meditation = '/mainMeditation';
  static const String stretching = '/mainStretching';
  static const String breathing = '/mainBreathing';
  static const String profile = '/mainProfile';
}

abstract final class ProfileRoutes {
  /// Nested routes
  static const String nestedEditProfile = 'profileEditProfile';

  /// Non-nested routes
  static const String language = '/language';
  static const String progress = '/profileProgress';
  static const String journalHistory = '/profileJournalHistory';
}

abstract final class MeditationsRoutes {
  /// Nested routes
  static const String nestedMeditationDetails = 'meditationDetails';

  /// Non-nested routes
  static const String settings = '/profileSettings';
  static const String progress = '/profileProgress';
  static const String journalHistory = '/profileJournalHistory';
  static const String meditationAudio = '/meditationAudio';
}

abstract final class BreathingsRoutes {
  static const String breathingAudio = '/breathingAudio';
}

abstract final class StretchingRoutes {
  static const String stretchingVideo = '/stretchingVideo';
}
