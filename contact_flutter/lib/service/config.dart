// config.dart
class Config {
  // ngrok URL - update this with your actual ngrok URL
  static const String baseUrl =
      'https://hilario-finialed-emmanuel.ngrok-free.dev';

  // API endpoints
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String registerEndpoint = '$baseUrl/auth/register';
  static const String contactsEndpoint = '$baseUrl/contacts';
  static const String verifyTokenEndpoint = '$baseUrl/auth/verify-token';
  static const String userEndpoint = '$baseUrl/auth/me';
}
