import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:belarus_exchange_app/styles.dart';

class SearchCityField extends StatelessWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String value)? onSaved;
  final int? maxLength;
  final TextInputFormatter? formatter;
  final String? prefix;
  final String? hint;
  final Function(String?)? onChanged;
  final String? helperText;
  final int? maxLines;

  const SearchCityField({
    Key? key,
    required this.labelText,
    this.keyboardType,
    this.focusNode,
    this.controller,
    this.onSaved,
    this.maxLength,
    this.formatter,
    this.prefix,
    this.hint,
    this.onChanged,
    this.helperText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        keyboardType: keyboardType,
        focusNode: focusNode,
        cursorColor: AppStyles.mainColor,
        controller: controller,
        inputFormatters: formatter != null ? [formatter!] : [],
        autocorrect: false,
        minLines: 1,
        maxLines: maxLines,
        textInputAction: TextInputAction.done,
        style: const TextStyle(color: AppStyles.mainTextColor),
        onChanged: onChanged,
        maxLength: maxLength,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppStyles.mainColor, width: 2),
                borderRadius: BorderRadius.circular(5)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1)),
            alignLabelWithHint: true,
            filled: true,
            isDense: true,
            fillColor: AppStyles.mainColor.withOpacity(0.03),
            labelText: labelText,
            prefixText: prefix,
            hintText: hint,
            helperText: helperText,
            labelStyle: const TextStyle(color: AppStyles.mainTextColor),
            hintStyle: const TextStyle(color: AppStyles.mainTextColor),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppStyles.mainColor.withOpacity(0.4), width: 1),
                borderRadius: BorderRadius.circular(5))),
        onSaved: (value) => onSaved?.call(value!),
      );
}
