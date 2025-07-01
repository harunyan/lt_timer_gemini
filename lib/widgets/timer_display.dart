import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int remainingSeconds;
  final Color timerColor;
  final double fontSize;

  const TimerDisplay({
    super.key,
    required this.remainingSeconds,
    required this.timerColor,
    required this.fontSize,
  });

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(
        _formatTime(remainingSeconds),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: timerColor,
        ),
      ),
    );
  }
}