echo "Welcome to gongmap utilities:"
echo
echo "[1]  build_runner build"
read -p "Run: " selection

case $selection in

    1)
    echo "build_runner build"
    flutter pub run build_runner build
    ;;

    *)
    echo "Unknown command!!"
    ;;

esac
