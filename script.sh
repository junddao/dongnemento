echo "Welcome to gongmap utilities:"
echo
echo "[1]  build_runner build"
echo "[2]  build_runner delete & build"
read -p "Run: " selection

case $selection in

    1)
    echo "build_runner build"
    flutter pub run build_runner build
    ;;

    2)
    echo "build_runner delete-conflictiong-outputs"
    flutter pub run build_runner build --delete-conflicting-outputs
    ;;



    *)
    echo "Unknown command!!"
    ;;

esac
