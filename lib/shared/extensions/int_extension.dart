extension IntExtension on int {
  int get toSeconds => this * 60;
  int get toMinutes => (this / 60).floor();

  String get formattedDurationString {
    String seconds = (this % 60).toInt().toString().padLeft(2, '0');
    String minutes = ((this / 60) % 60).toInt().toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }
}
