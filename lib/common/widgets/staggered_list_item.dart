import 'package:flutter/material.dart';

/// Wraps any widget with a staggered fade + slide-up entrance animation.
/// Each item's [index] controls how long it waits before animating in,
/// so items in a list/grid appear one after another instead of all at once.
class StaggeredListItem extends StatefulWidget {
  const StaggeredListItem({
    super.key,
    required this.index,
    required this.child,
    this.itemDelay = 80,
    this.animationDuration = 400,
  });

  final int index;
  final Widget child;

  /// Milliseconds between each item's entrance (default 80 ms).
  final int itemDelay;

  /// How long the entrance animation itself plays (default 400 ms).
  final int animationDuration;

  @override
  State<StaggeredListItem> createState() => _StaggeredListItemState();
}

class _StaggeredListItemState extends State<StaggeredListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Stagger: each item waits a little longer than the previous
    Future.delayed(
      Duration(milliseconds: widget.index * widget.itemDelay),
      () {
        if (mounted) _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: widget.child,
        ),
      );
}
