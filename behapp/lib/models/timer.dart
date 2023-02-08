import 'dart:async';

class CustomTimer {
  int targetTime;
  int elapsedTime;
  TimerState state = TimerState.running;

  CustomTimer({
    required this.targetTime,
    required this.elapsedTime,
  });

  void start() {
    state = TimerState.running;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (state == TimerState.running) {
        elapsedTime++;
        if (elapsedTime >= targetTime) {
          timer.cancel();
        }
      }
    });
  }

  void pause() {
    state = TimerState.paused;
  }

  int getTimeExceeded() {
    if (elapsedTime > targetTime) {
      return elapsedTime - targetTime;
    }
    return 0;
  }

  void addListener() {}
}

enum TimerState {
  running,
  paused,
}
