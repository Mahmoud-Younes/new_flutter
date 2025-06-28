import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  const CountdownTimer({Key? key, required this.endTime}) : super(key: key);

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    final now = DateTime.now();
    _duration = widget.endTime.difference(now);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration = _duration - const Duration(seconds: 1);
      });
      if (_duration.inSeconds <= 0) {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCountdownItem(
          label: 'Days',
          value: _duration.inDays.remainder(30).toString().padLeft(2, '0'),
        ),
        const SizedBox(width: 30),
        _buildCountdownItem(
          label: 'Hours',
          value: _duration.inHours.remainder(24).toString().padLeft(2, '0'),
        ),
        const SizedBox(width: 30),
        _buildCountdownItem(
          label: 'Min',
          value: _duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        ),
        const SizedBox(width: 30),
        _buildCountdownItem(
          label: 'Sec',
          value: _duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
        ),
      ],
    );
  }

  Widget _buildCountdownItem({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
