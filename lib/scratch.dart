main() {
  String x = 'abcdefghij';
  List y = x.split('');
  y[0] = 'w';
  x = y.join('');
  print(x);
}
