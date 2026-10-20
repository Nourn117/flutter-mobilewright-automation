const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// 2499 -> "EGP 2,499", 45.5 -> "EGP 45.50"
String formatPrice(num value) {
  final whole = value.abs().truncate();
  final digits = whole.toString();
  final grouped = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) grouped.write(',');
    grouped.write(digits[i]);
  }
  final piasters = ((value.abs() - whole) * 100).round();
  final fraction =
      piasters == 0 ? '' : '.${piasters.toString().padLeft(2, '0')}';
  return 'EGP ${value < 0 ? '-' : ''}$grouped$fraction';
}

/// 2026-10-21 -> "Wed, 21 Oct 2026"
String formatDate(DateTime d) =>
    '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]} ${d.year}';
