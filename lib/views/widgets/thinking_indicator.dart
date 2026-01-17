import 'typing_dots.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget thinkingIndicator() {
  return Shimmer.fromColors(
    baseColor: Colors.blueAccent.shade400,
    highlightColor: Colors.blueGrey.shade100,
    child: const TypingDots(),
  );
}
