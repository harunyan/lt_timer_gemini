import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config_screen.dart';

// 条件付きインポート
import 'package:flutter/foundation.dart' show kIsWeb;
import 'main_desktop.dart' if (dart.library.html) 'main_web.dart';

// 新しいウィジェットのインポート
import 'widgets/timer_display.dart';
import 'widgets/control_buttons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await initializeDesktop();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LT Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const String _initialTimeKey = 'initialTime';
  static const String _startNotifyTimeKey = 'startNotifyTime'; // 追加
  static const int _defaultInitialTime = 5 * 60; // 5 minutes
  static const int _defaultStartNotifyTime = 0; // デフォルトの開始通知時間 (0秒)
  static const int _warningTime = 60; // 1 minute warning

  int _initialTimeInSeconds = _defaultInitialTime;
  int _remainingSeconds = _defaultInitialTime;
  int _startNotifyTimeInSeconds = _defaultStartNotifyTime; // 追加
  Timer? _timer;
  bool _isRunning = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadInitialTime();
  }

  Future<void> _loadInitialTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _initialTimeInSeconds = prefs.getInt(_initialTimeKey) ?? _defaultInitialTime;
      _remainingSeconds = _initialTimeInSeconds;
      _startNotifyTimeInSeconds = prefs.getInt(_startNotifyTimeKey) ?? _defaultStartNotifyTime; // 追加
    });
  }

  Future<void> _saveInitialTime(int mainTime, int startNotifyTime) async { // 引数を追加
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_initialTimeKey, mainTime);
    await prefs.setInt(_startNotifyTimeKey, startNotifyTime); // 追加
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _checkTimeForSound();
        } else {
          _timer?.cancel();
          _isRunning = false;
          _playSound('end.mp3');
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _initialTimeInSeconds;
      _isRunning = false;
    });
  }

  void _playSound(String filename) async {
    try {
      await _audioPlayer.play(AssetSource('sound/$filename'));
    } catch (e) {
      print('Error playing sound $filename: $e');
    }
  }

  void _checkTimeForSound() {
    if (_remainingSeconds == _warningTime) {
      _playSound('warning.mp3');
    }
    if (_remainingSeconds == _initialTimeInSeconds - _startNotifyTimeInSeconds) { // 開始通知時間になったら
      _playSound('start.mp3');
    }
  }

  Color _getTimerColor() {
    if (_remainingSeconds <= 0) {
      return Colors.red;
    } else if (_remainingSeconds <= _warningTime) {
      return Colors.yellow;
    } else {
      return Colors.blue;
    }
  }

  void _openConfigScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfigScreen(
          initialTimeInSeconds: _initialTimeInSeconds,
          startNotifyTimeInSeconds: _startNotifyTimeInSeconds, // 追加
        ),
      ),
    );

    if (result != null && result is Map<String, int>) { // Mapで受け取る
      setState(() {
        _initialTimeInSeconds = result['mainTime']!;
        _remainingSeconds = result['mainTime']!;
        _startNotifyTimeInSeconds = result['startNotifyTime']!; // 追加
        _saveInitialTime(_initialTimeInSeconds, _startNotifyTimeInSeconds); // 両方を保存
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double fontSize = screenSize.shortestSide * 0.3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LT Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openConfigScreen,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TimerDisplay(
              remainingSeconds: _remainingSeconds,
              timerColor: _getTimerColor(),
              fontSize: fontSize,
            ),
            ControlButtons(
              isRunning: _isRunning,
              onStartPause: _isRunning ? _pauseTimer : _startTimer,
              onReset: _resetTimer,
              screenSize: screenSize,
            ),
          ],
        ),
      ),
    );
  }
}