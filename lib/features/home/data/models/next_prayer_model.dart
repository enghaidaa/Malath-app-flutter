class NextPrayerModel {
  final String prayerKey;
  final String prayerTime;
  final Duration remaining;
  final bool isTomorrow;

  const NextPrayerModel({
    required this.prayerKey,
    required this.prayerTime,
    required this.remaining,
    this.isTomorrow = false,
  });

  String get formattedCountdown {
    if (remaining.isNegative) return '00:00:00';
    final hours = remaining.inHours.toString().padLeft(2, '0');
    final minutes = (remaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (remaining.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
