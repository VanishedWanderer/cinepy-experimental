import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';

class NiceStepper extends StatefulWidget{
  const NiceStepper({Key key,
    @required this.states
  }): super(key: key);

  final List<Widget> states;

  @override
  State createState() => _NiceStepperState();
}

class _NiceStepperState extends State<NiceStepper>{

  Widget _currentChild;


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> anim, Animation<double> secondAnim){
              return SharedAxisTransition(
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
                animation: anim,
                secondaryAnimation: secondAnim,
              );
            },
            child: _currentChild,
          ),
        )
      ],
    );
  }
}