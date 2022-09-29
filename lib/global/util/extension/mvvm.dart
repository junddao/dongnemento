import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

extension MvvmExtension<V extends ViewModel> on StatelessView<V> {
  Widget vmSelector({required dynamic Function(V vm) selector, required Widget Function() builder}) {
    return Builder(
      builder: (ctx) {
        ctx.select<V, dynamic>(selector);
        return builder();
      },
    );
  }
}
