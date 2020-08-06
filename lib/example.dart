/// Flutter code sample for InteractiveViewer.transformationController

// This example shows how transformationController can be used to animate the
// transformation back to its starting position.

import 'package:flutter/material.dart';

/// This is the main application widget.
class MySecondApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  Animation<Matrix4> _animationReset;
  AnimationController _controllerReset;
  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _controllerReset.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerReset = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  void _onAnimateReset() {
    _transformationController.value = _animationReset.value;
    if (!_controllerReset.isAnimating) {
      _animationReset?.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset.reset();
    }
  }

  void _animateResetInitialize() {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_controllerReset);
    _animationReset.addListener(_onAnimateReset);
    _controllerReset.forward();
  }

// Stop a running reset to home transform animation.
  void _animateResetStop() {
    _controllerReset.stop();
    _animationReset?.removeListener(_onAnimateReset);
    _animationReset = null;
    _controllerReset.reset();
  }

  void _onInteractionStart(ScaleStartDetails details) {
    // If the user tries to cause a transformation while the reset animation is
    // running, cancel the reset animation.
    if (_controllerReset.status == AnimationStatus.forward) {
      _animateResetStop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Controller demo'),
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(double.infinity),
          transformationController: _transformationController,
          minScale: 0.1,
          maxScale: 2.0,
          // onInteractionStart: _onInteractionStart,
          onInteractionStart: (_) => print('😻 interaction started'),
          onInteractionUpdate: (_) => print('⛩ interaction updating'),
          onInteractionEnd: (_) => print('🏔 interaction ended'),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.yellow, Colors.green],
                stops: <double>[0.0, 1.0],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        IconButton(
          onPressed: _animateResetInitialize,
          tooltip: 'Reset',
          color: Theme.of(context).colorScheme.surface,
          icon: const Icon(Icons.replay),
        ),
      ],
    );
  }
}
