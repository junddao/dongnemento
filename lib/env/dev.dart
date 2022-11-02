import 'package:base_project/env/environment.dart';
// import 'package:flutter_flavor/flutter_flavor.dart';

main() {
  // FlavorConfig(
  //     name: "dev",
  //     color: Colors.red,
  //     location: BannerLocation.topEnd,
  //     variables: {
  //       "counter": 0,
  //     });
  Environment.newInstance(BuildType.dev).run();
}
