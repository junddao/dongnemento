import 'package:base_project/main_common.dart';

enum BuildType {
  dev,
  stage,
  prod,
}

class Environment {
  static Environment? instance;

  final BuildType _buildType;

  static BuildType get buildType => instance!._buildType;

  const Environment.internal(this._buildType);

  factory Environment.newInstance(BuildType buildType) {
    instance ??= Environment.internal(buildType);
    return instance!;
  }

  void run() async {
    mainCommon();
  }
}
