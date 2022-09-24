
String noToPosition(int number) {
  switch(number) {
    case 1:
      return '1st';
    case 2:
      return '2nd';
    case 3:
      return '3rd';
    default:
      return '${number}th';
  }
}