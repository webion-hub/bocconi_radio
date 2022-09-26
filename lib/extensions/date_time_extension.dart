extension DateTimeExtension on DateTime {
  String toShortString() {
    final month = [
      "Gen",
      "Feb",
      "Mar",
      "Apr",
      "Mag",
      "Giu",
      "Lug",
      "Ago",
      "Set",
      "Ott",
      "Nov",
      "Dic",
    ][this.month - 1];

    return '$day $month $year';
  }
}