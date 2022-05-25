import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String format(DateFormat format) {
    return format.format(this);
  }

  String formatYYYY() {
    return DateFormat('yyyy').format(this);
  }


  String formatYYYYMMdd() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String formatddMMyyyy() {
    return DateFormat("dd/MM/yyyy").format(this);
  }

  String formatMMddyyyy() {
    return DateFormat("MM/dd/yyyy").format(this);
  }

  String formatMMdd() {
    return DateFormat("MM/dd").format(this);
  }

  String formatHHmmddMMyyyy() {
    return DateFormat("HH:mm dd/MM/yyyy").format(this);
  }

  String formatMMddyyyyHHmm() {
    return DateFormat("yyyy/MM/dd HH:mm").format(this);
  }

  String formatHHmm() {
    return DateFormat("HH:mm").format(this);
  }

  String formatHHmmMMM() {
    return DateFormat("HH:mm MMM. ").format(this);
  }

  String formatHHmmaa() {
    return DateFormat("HH:mm a").format(this);
  }

  String formatHHmmssaa() {
    return DateFormat("HH:mm:ss a").format(this);
  }

  DateTime clearHHmmss() {
    return DateTime.parse(formatYYYYMMdd());
  }
}
