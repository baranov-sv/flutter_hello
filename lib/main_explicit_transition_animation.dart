import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const double smallIconSize = 24.0;
const double largeIconSize = 196.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
            child: TimeMachine(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimeMachine extends StatefulWidget {
  @override
  _TimeMachineState createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: RotationTransition(
            turns: _animationController,
            child: GalaxyFitz(),
          ),
        ),

        /*** Hidden Button -- Stops time. ***/
        Align(
          alignment: Alignment.bottomLeft,
          child: TimeStopper(
            controller: _animationController
          ),
        ),
      ],
    );
  }
}

/// Hidden button that stops all the given animations, or restart them if not running.
class TimeStopper extends StatelessWidget {
  final AnimationController controller;

  const TimeStopper({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.isAnimating) {
          controller.stop();
        } else {
          controller.repeat();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        width: 100,
        height: 100,
      ),
    );
  }
}

/// The galaxy fits, so we'll just put it here...
class GalaxyFitz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset("images/galaxy_transparent.png");
  }
}
