import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:vector_math/vector_math_64.dart';

class ThreeDTransformer extends PageTransformer {
  @override
  Widget transform(Widget child, TransformInfo info) {
    double position = info.position;
    double height = info.height;
    double width = info.width;
    double pivotX = 0.0;
    if (position < 0 && position >= -1) {
      // left scrolling
      pivotX = width;
    }
    return new Transform(
      transform: new Matrix4.identity()
        ..rotate(new Vector3(0.0, 2.0, 0.0), position * 1.5),
      origin: new Offset(pivotX, height / 2),
      child: child,
    );
  }
}
