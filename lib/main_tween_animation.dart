import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OngoingAnimationByModifyingEndTweenValue(),
    );
  }
}

class OngoingAnimationByModifyingEndTweenValue extends StatefulWidget {
  @override
  _OngoingAnimationState createState() => _OngoingAnimationState();
}

class _OngoingAnimationState extends State<OngoingAnimationByModifyingEndTweenValue> {
  double _newValue = .4;
  Color _newColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: TweenAnimationBuilder(
                      tween: ColorTween(begin: Colors.white, end: _newColor),
                      duration: Duration(seconds: 2),
                      builder: (_, Color color, __) {
                        return ColorFiltered(
                          child: Image.network('https://picsum.photos/250?image=9'),
                          colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                        );
                      },
                    ),
                  ),
                  Slider.adaptive(
                    value: _newValue,
                    onChanged: (double value) {
                      setState(() {
                        _newValue = value;
                        _newColor = Color.lerp(Colors.white, Colors.red, value);
                      });
                    },
                  ),
                ],
              ),
            ],
        )
      )
    );
  }
}
