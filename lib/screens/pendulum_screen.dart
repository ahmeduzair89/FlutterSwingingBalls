import 'package:flutter/material.dart';
import 'package:pendulum_app/widgets/pendulum_widget.dart';

class PendulumScreen extends StatefulWidget {
  const PendulumScreen({super.key});

  @override
  State<PendulumScreen> createState() => _PendulumScreenState();
}

class _PendulumScreenState extends State<PendulumScreen>
    with TickerProviderStateMixin {
  late Animation<double> startPendulumAnimation;
  late AnimationController startPendulumController;
  late Animation<double> endPendulumAnimation;
  late AnimationController endPendulumController;

  @override
  void initState() {
    endPendulumController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          endPendulumController.reverse();
        }
        setState(() {});
      });
    startPendulumController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          endPendulumController.forward();
          Future.delayed(const Duration(milliseconds: 1000))
              .whenComplete(() => startPendulumController.reverse());
        }
        if (status == AnimationStatus.dismissed) {
          startPendulumController.forward();
        }
        setState(() {});
      });

    startPendulumAnimation = Tween<double>(
      begin: 1 / 15,
      end: 0,
    ).animate(startPendulumController);
    endPendulumAnimation = Tween<double>(
      begin: 0,
      end: -(1 / 15),
    ).animate(endPendulumController);
    startPendulumController.forward();
    super.initState();
  }

  @override
  void dispose() {
    startPendulumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 7,
                    blurRadius: 15,
                    offset: Offset(0, 0))
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.brown.shade900,
                  Colors.brown.shade700,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                alignment: Alignment.topCenter,
                turns: startPendulumAnimation,
                child: PendulumWidget(ballColor: 'white'),
              ),
              PendulumWidget(),
              PendulumWidget(),
              PendulumWidget(),
              PendulumWidget(),
              RotationTransition(
                alignment: Alignment.topCenter,
                turns: endPendulumAnimation,
                child: PendulumWidget(ballColor: 'white'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
