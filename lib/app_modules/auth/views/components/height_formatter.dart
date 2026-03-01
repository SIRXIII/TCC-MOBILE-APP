import '../../../../utils/app_imports.dart';

class HeightFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove everything except numbers
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Max 3 digits (e.g. 6'10)
    if (digits.length > 3) {
      digits = digits.substring(0, 3);
    }

    String formatted;

    if (digits.length <= 1) {
      formatted = digits;
    } else {
      formatted = "${digits.substring(0, 1)}'${digits.substring(1)}";
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
