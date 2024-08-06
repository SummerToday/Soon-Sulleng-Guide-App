import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationInfo {
  final AnimationTrigger trigger;
  final List<Effect> effects;

  AnimationInfo({
    required this.trigger,
    required this.effects,
  });
}

enum AnimationTrigger {
  onPageLoad,
}

extension AnimateOnPageLoad on Widget {
  Widget animateOnPageLoad(AnimationInfo info) {
    return Animate(
      effects: info.effects,
      child: this,
    );
  }
}
