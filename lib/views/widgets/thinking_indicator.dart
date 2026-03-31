import 'typing_dots.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget thinkingIndicator({String? text}) {
  return Shimmer.fromColors(
    baseColor: Colors.blueAccent.shade400,
    highlightColor: Colors.blueAccent.shade700,
    child: TypingDots(text: text),
  );
}
