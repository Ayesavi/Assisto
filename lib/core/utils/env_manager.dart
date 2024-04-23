enum AppEnvironment {
  release,
  staging,
  development,
}

extension GetBoolEnv on AppEnvironment {
  bool get isRelease => this == AppEnvironment.release;
  bool get isStaging => this == AppEnvironment.staging;
  bool get isDevelopment => this == AppEnvironment.development;
}

AppEnvironment _mapStringToAppEnvironment(String env) {
  switch (env) {
    case 'release':
      return AppEnvironment.development;
    case 'staging':
      return AppEnvironment.development;
    case 'development':
      return AppEnvironment.development;
    default:
      throw Exception('env does not match to existing environments');
  }
}

class EnvManager {
  static final EnvManager _instance = EnvManager._internal();

  factory EnvManager() {
    return _instance;
  }

  EnvManager._internal();

  static final appEnvironment =
      _mapStringToAppEnvironment(const String.fromEnvironment('env'));
}
