import 'package:base_project/env/environment.dart';

main() {
  // FlavorConfig(
  //     name: "dev",
  //     color: Colors.red,
  //     location: BannerLocation.topEnd,
  //     variables: {
  //       "counter": 0,
  //     });
  Environment.newInstance(BuildType.stage).run();
}
