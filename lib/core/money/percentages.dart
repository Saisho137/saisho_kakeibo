/// Whole percentages of [shares] (fractions that add up to 1) that add up
/// to exactly 100: each is rounded down and the points left go to the
/// largest remainders, so 62.5 % and 37.5 % show as 63 % and 37 %.
List<int> roundPercents(List<double> shares) {
  final exact = [for (final share in shares) share * 100];
  final percents = [for (final value in exact) value.floor()];
  final total = exact.fold<double>(0, (sum, value) => sum + value).round();
  final byRemainder = List.generate(shares.length, (i) => i)
    ..sort((a, b) {
      final byRest = (exact[b] - percents[b]).compareTo(exact[a] - percents[a]);
      return byRest != 0 ? byRest : a.compareTo(b);
    });
  var left = total - percents.fold(0, (sum, p) => sum + p);
  for (final index in byRemainder) {
    if (left <= 0) break;
    percents[index]++;
    left--;
  }
  return percents;
}
