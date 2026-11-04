
sealed class Countdown {}

class Upcoming extends Countdown {
  Upcoming(this.remaining);
  final Duration remaining;
}

class Started extends Countdown {
  Started(this.elapsed);
  final Duration elapsed;
}

class Ended extends Countdown {}

Countdown calculateCountdown(DateTime when) {
  final now = DateTime.now();
  final diff = when.difference(now);

  if (diff.isNegative) {
    if (diff.abs().inHours < 2) {
      return Started(diff.abs());
    }
    return Ended();
  } else {
    return Upcoming(diff);
  }
}