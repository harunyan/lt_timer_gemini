import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ConfigScreen extends StatefulWidget {
  final int initialTimeInSeconds;
  final int startNotifyTimeInSeconds; // 追加

  const ConfigScreen({
    super.key,
    required this.initialTimeInSeconds,
    required this.startNotifyTimeInSeconds, // 追加
  });

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  late int _currentMinutes;
  late int _currentSeconds;
  late int _startNotifyMinutes; // 追加
  late int _startNotifySeconds; // 追加

  @override
  void initState() {
    super.initState();
    _currentMinutes = widget.initialTimeInSeconds ~/ 60;
    _currentSeconds = widget.initialTimeInSeconds % 60;
    _startNotifyMinutes = widget.startNotifyTimeInSeconds ~/ 60; // 追加
    _startNotifySeconds = widget.startNotifyTimeInSeconds % 60; // 追加
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // メインタイマー設定
            Text(
              'メインタイマー: ${_currentMinutes.toString().padLeft(2, '0')}:${_currentSeconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // スペースを増やす
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        setState(() {
                          _currentMinutes = (_currentMinutes + 1).clamp(0, 5);
                        });
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: NumberPicker(
                        value: _currentMinutes,
                        minValue: 0,
                        maxValue: 5,
                        itemHeight: 80,
                        itemWidth: 80,
                        textStyle: const TextStyle(fontSize: 20, color: Colors.grey),
                        selectedTextStyle: const TextStyle(fontSize: 36, color: Colors.blue, fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          setState(() {
                            _currentMinutes = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        setState(() {
                          _currentMinutes = (_currentMinutes - 1).clamp(0, 5);
                        });
                      },
                    ),
                  ],
                ),
                const Text('分', style: TextStyle(fontSize: 20)),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        setState(() {
                          _currentSeconds = (_currentSeconds + 5).clamp(0, 55);
                        });
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: NumberPicker(
                        value: _currentSeconds,
                        minValue: 0,
                        maxValue: 55,
                        step: 5,
                        itemHeight: 80,
                        itemWidth: 80,
                        textStyle: const TextStyle(fontSize: 20, color: Colors.grey),
                        selectedTextStyle: const TextStyle(fontSize: 36, color: Colors.blue, fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          setState(() {
                            _currentSeconds = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        setState(() {
                          _currentSeconds = (_currentSeconds - 5).clamp(0, 55);
                        });
                      },
                    ),
                  ],
                ),
                const Text('秒', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 40), // スペースを増やす

            // 開始通知時間設定
            Text(
              '開始通知時間: ${_startNotifyMinutes.toString().padLeft(2, '0')}:${_startNotifySeconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        setState(() {
                          _startNotifyMinutes = (_startNotifyMinutes + 1).clamp(0, 5);
                        });
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: NumberPicker(
                        value: _startNotifyMinutes,
                        minValue: 0,
                        maxValue: 5,
                        itemHeight: 80,
                        itemWidth: 80,
                        textStyle: const TextStyle(fontSize: 20, color: Colors.grey),
                        selectedTextStyle: const TextStyle(fontSize: 36, color: Colors.blue, fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          setState(() {
                            _startNotifyMinutes = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        setState(() {
                          _startNotifyMinutes = (_startNotifyMinutes - 1).clamp(0, 5);
                        });
                      },
                    ),
                  ],
                ),
                const Text('分', style: TextStyle(fontSize: 20)),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        setState(() {
                          _startNotifySeconds = (_startNotifySeconds + 5).clamp(0, 55);
                        });
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: NumberPicker(
                        value: _startNotifySeconds,
                        minValue: 0,
                        maxValue: 55,
                        step: 5,
                        itemHeight: 80,
                        itemWidth: 80,
                        textStyle: const TextStyle(fontSize: 20, color: Colors.grey),
                        selectedTextStyle: const TextStyle(fontSize: 36, color: Colors.blue, fontWeight: FontWeight.bold),
                        onChanged: (value) {
                          setState(() {
                            _startNotifySeconds = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        setState(() {
                          _startNotifySeconds = (_startNotifySeconds - 5).clamp(0, 55);
                        });
                      },
                    ),
                  ],
                ),
                const Text('秒', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int newMainTimeInSeconds = _currentMinutes * 60 + _currentSeconds;
                int newStartNotifyTimeInSeconds = _startNotifyMinutes * 60 + _startNotifySeconds;

                // メインタイマーのバリデーション
                if (newMainTimeInSeconds < 5) {
                  newMainTimeInSeconds = 5;
                } else if (newMainTimeInSeconds > 305) {
                  newMainTimeInSeconds = 305;
                }

                // 開始通知時間のバリデーション (メインタイマー時間以下に制限)
                if (newStartNotifyTimeInSeconds > newMainTimeInSeconds) {
                  newStartNotifyTimeInSeconds = newMainTimeInSeconds;
                } else if (newStartNotifyTimeInSeconds < 0) { // 負の値にならないように
                  newStartNotifyTimeInSeconds = 0;
                }

                Navigator.pop(context, {
                  'mainTime': newMainTimeInSeconds,
                  'startNotifyTime': newStartNotifyTimeInSeconds,
                });
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}