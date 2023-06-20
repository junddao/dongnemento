import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/style.dart';
import 'package:flutter/material.dart';

class DUDialog {
  static Future<bool> showTwoButtonDialog({
    required BuildContext context,
    String? title,
    String? subTitle,
    String? btn1Text,
    String? btn2Text,
  }) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)), //this right here

          child: SizedBox(
            width: 270,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  title ?? '잠시만요',
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle: FontStyle.normal,
                      fontSize: 17.0),
                ),
                const SizedBox(height: 8),
                Text(
                  subTitle ?? '등록을 취소하시겠습니까?',
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansCJKkr",
                      fontStyle: FontStyle.normal,
                      fontSize: 13.0),
                ),
                const SizedBox(height: 20),
                const Divider(height: 0),
                SizedBox(
                  height: 43.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            btn1Text ?? '다시입력',
                            style: DUTextStyle.size14.grey1,
                          ),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text(
                            btn2Text ?? '등록취소',
                            style: DUTextStyle.size14.warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }

  static Future<bool?> showOneButtonDialog({
    required BuildContext context,
    String? title,
    String? subTitle,
    String? btnText,
  }) async {
    bool? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)), //this right here

          child: SizedBox(
            width: 270,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  title ?? '잠시만요',
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontFamily: "AppleSDGothicNeo",
                      fontStyle: FontStyle.normal,
                      fontSize: 17.0),
                ),
                const SizedBox(height: 20),
                Text(
                  subTitle ?? '등록을 취소하시겠습니까?',
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansCJKkr",
                      fontStyle: FontStyle.normal,
                      fontSize: 13.0),
                ),
                const SizedBox(height: 20),
                const Divider(height: 0),
                SizedBox(
                  height: 43.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text(
                            btnText ?? '확인',
                            style: DUTextStyle.size14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return result;
  }
}
