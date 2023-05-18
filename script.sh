echo "Welcome to du_mobile utilities:"
echo
echo "[0] build runner"
echo "[1] build runner --delete-conflicting-outputs"
echo "[2] 데브 모드로 실행"
echo "[3] 라이브 모드로 실행"
echo "[4] fastlane aos (dev)"
echo "[5] fastlane ios (dev)"
echo "[6] fastlane aos (prod)"
echo "[7] fastlane ios (prod)"
echo
read -p "Run: " selection

case $selection in

    0)
    echo "build_runner"
    flutter pub run build_runner build
    ;;

    1)
    echo "build_runner"
    flutter pub run build_runner build --delete-conflicting-outputs
    ;;

    2)
    echo "run main(dev)"
    flutter run -t lib/main_dev.dart
    ;;

    3)
    echo "run main(live)"
    flutter run -t lib/main_prod.dart
    ;;

    4)
    echo "fastlane aos (dev)"
    cd android/fastlane && fastlane beta --env dev
    ;;

    5)
    echo "fastlane ios (dev)"
    flutter build ios --debug -t lib/main_dev.dart && 
    cd ios/fastlane && 
    fastlane beta --env dev
    ;;

    6)
    echo "fastlane aos (prod)"
    cd android/fastlane && fastlane prod --env prod
    ;;

    7)
    echo "fastlane ios (prod)"
    flutter clean && flutter build ios -t lib/main_prod.dart && 
    cd ios/fastlane && 
    fastlane prod --env prod
    ;;

    *)
    echo "Unknown command!!"
    ;;

esac
