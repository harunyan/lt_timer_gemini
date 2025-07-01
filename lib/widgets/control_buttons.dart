import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStartPause;
  final VoidCallback onReset;
  final Size screenSize;

  const ControlButtons({
    super.key,
    required this.isRunning,
    required this.onStartPause,
    required this.onReset,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onStartPause,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
                textStyle: TextStyle(fontSize: screenSize.shortestSide * 0.08),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(isRunning ? 'Pause' : 'Start'),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onReset,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.05),
                textStyle: TextStyle(fontSize: screenSize.shortestSide * 0.08),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: const Text('Reset'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}