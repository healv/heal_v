abstract final class AppRoutes {
  /// Launch route
  static const String launch = '/launch';
}

abstract final class AuthRoutes {
  static const String welcome = '/authWelcome';
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
  static const String nestedEditProfile = 'settingsEditProfile';

  /// Non-nested routes
  static const String appearance = '/settingsAppearance';
  static const String autoNightMode = '/settingsAutoNightMode';
  static const String dataAndStorage = '/settingsDataAndStorage';
  static const String privacyAndSecurity = '/settingsPrivacyAndSecurity';
  static const String notifications = '/settingsNotifications';
  static const String devices = '/settingsDevices';
}
