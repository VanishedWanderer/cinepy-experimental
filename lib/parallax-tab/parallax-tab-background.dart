import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParallaxTabBackground extends StatelessWidget{

  const ParallaxTabBackground({@required this.child}): super();

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animation<double> anim = DefaultTabController.of(context).animation;
    var oneTabSize = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: anim,
      builder: (BuildContext context, Widget child){
        debugPrint("${anim.value}");
        double offset = anim.value;
        return OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment(offset, -1),
            child: this.child
        );
      },
    );
  }
}