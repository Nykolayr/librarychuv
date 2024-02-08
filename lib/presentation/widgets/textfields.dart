import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:librarychuv/presentation/theme/different.dart';
import 'package:librarychuv/presentation/theme/text.dart';

class LibFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Widget? suffix;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final String? textPrefix;
  final String? errorText;
  final bool obscureText;
  final int? maxLength;
  final int maxLines;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final bool isDense;
  final bool readOnly;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final String? subText;
  final bool isTitle;
  final String title;

  const LibFormField({
    super.key,
    this.controller,
    this.hint,
    this.suffix,
    this.suffixText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.textPrefix,
    this.errorText,
    this.obscureText = false,
    this.maxLength,
    this.maxLines = 1,
    this.textAlign,
    this.keyboardType,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.isDense = true,
    this.readOnly = false,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.subText,
    this.isTitle = false,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTitle && title.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 3, top: 10),
            child: Text(
              hint ?? '',
              style: AppText.text12g,
            ),
          ),
        if (title.isNotEmpty) Text(title, style: AppText.captionText14b),
        if (title.isNotEmpty) const Gap(7),
        SizedBox(
          height: 45 * maxLines.toDouble(),
          child: TextFormField(
            onChanged: onChanged ??
                (text) {
                  String newText = text.isNotEmpty && controller != null
                      ? text[0].toUpperCase() + text.substring(1)
                      : text;
                  controller!.text = newText;
                },
            obscureText: obscureText,
            maxLength: maxLength,
            readOnly: readOnly,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            onTap: onTap,
            textAlign: textAlign ?? TextAlign.start,
            keyboardType: keyboardType,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            validator: validator,
            controller: controller,
            textInputAction: textInputAction,
            decoration: AppDif.getInputDecoration(hint: hint ?? ''),
          ),
        ),
      ],
    );
  }
}
