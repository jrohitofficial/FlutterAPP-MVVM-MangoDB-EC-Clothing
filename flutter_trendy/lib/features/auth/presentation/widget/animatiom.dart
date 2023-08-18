import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  final Widget? child;
  final double? offset;
  final Duration? duration;
  final Axis? axis;
  final Curve? curve;

  AnimationWidget({
    Key? key,
    @required this.child,
    this.axis = Axis.horizontal,
    this.curve = Curves.elasticOut,
    this.duration = const Duration(milliseconds: 800),
    this.offset = 140.0,
  }) : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 10.0, end: 0.0),
      duration: widget.duration!,
      curve: widget.curve!,
      child: widget.child,
      builder: (context, value, child) {
        return Transform.translate(
          offset: widget.axis! == Axis.horizontal
              ? Offset(value * widget.offset!, 0.0)
              : Offset(0.0, value * widget.offset!),
          child: widget.child,
        );
      },
    );
  }
}
