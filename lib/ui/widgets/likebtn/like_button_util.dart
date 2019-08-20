import 'dart:math' as math;

num degToRad(num deg) => deg * (math.pi / 180);

num radTodeg(num rad) => rad * (180 * math.pi);

double mapValueFromRangeToRange(double value, double fromLow, double fromHigh,
    double toLow, double toHigh) {
  return toLow + ((value - fromLow) / (fromHigh - fromLow) * (toHigh - toLow));
}
double clamp(double value, double low, double high) {
  return math.min(math.max(value, low), high);
}