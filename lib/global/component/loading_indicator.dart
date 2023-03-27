import 'dart:async';

import 'package:flutter/material.dart';

Future<BuildContext> showLoadingIndicator(BuildContext context) {
  var dialogContext = Completer<BuildContext>();
  showDialog(
    context: context,
    builder: (_) {
      if (!dialogContext.isCompleted) dialogContext.complete(_);
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      );
    },
    barrierDismissible: false,
  );
  return dialogContext.future;
}
