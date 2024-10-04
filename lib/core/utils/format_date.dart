import 'package:intl/intl.dart';

String formatDateBydMMMYYYY(DateTime dateTime) {
  return DateFormat("MMM d, yyyy").format(dateTime);
}
