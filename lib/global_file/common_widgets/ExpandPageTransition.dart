import 'package:flutter/cupertino.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ExpandPageTransition extends StatelessWidget {
  const ExpandPageTransition({
    this.closedBuilder,
    this.transitionType,
    this.navigateToPage,
  });

  final OpenContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final Widget navigateToPage;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return navigateToPage;
      },
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}