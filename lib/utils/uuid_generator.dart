import 'package:uuid/uuid.dart';

String generateTimeBasedId() {
  return const Uuid().v1();
}