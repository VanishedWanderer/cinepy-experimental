///Author: Erik Mayrhofer

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A widget which can be used inside a TabController to create a parallax-background-effect
///
/// This widget is intended to be used inside of a Stack element like this:
///
/// ```
///child: Stack(
///  children: [
///    Padding(
///      child: ParallaxTabBackground(
///        child: [...]
///      ),
///    ),
///    TabBarView(
///      children: [...],
///    ),
///  ]
///),
/// ```
///
/// The width of the [child] and the number of tabs determines the speed in which
/// the parallax moves in such a way, that the right and left end of all tabs
/// align with the background.
///
class ParallaxTabBackground extends StatelessWidget{
  const ParallaxTabBackground({
    @required this.child,
    this.controller
  }): super();

  final Widget child;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    var tabController = controller ?? DefaultTabController.of(context);
    assert(tabController != null);

    Animation<double> anim = tabController.animation;
    var maxValue = tabController.length-1;

    return AnimatedBuilder(
      animation: anim,
      builder: (BuildContext context, Widget child){
        double offset = (anim.value / maxValue)*2.0-1.0; // Map the range of the animation (0 .. tabCount-1) to the range of the Alignment (-1 .. 1)
        return OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment(offset, -1),
            child: this.child
        );
      },
    );
  }
}