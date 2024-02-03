import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

/// преобразование текста с url в текст с выделенной ссылкой
class RedLinkWidget extends StatelessWidget {
  final String text;
  final Function(String)? onTap;
  const RedLinkWidget({required this.text, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final RegExp urlRegex = RegExp(
      r'(http[^\s]+\.pdf)',
      caseSensitive: false,
    );
    final Match? match = urlRegex.firstMatch(text);
    final String? url = match?.group(1);
    List<String> textList = [];
    if (url != null) {
      textList = text.split(url);
    }
    return RichText(
      text: TextSpan(
        text: text,
        style: AppText.text12b.copyWith(color: AppColor.greyText),
        children: [
          if (url != null) ...[
            TextSpan(text: textList[0]),
            TextSpan(
              text: url,
              style: AppText.text12b.copyWith(color: AppColor.redMain),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onTap?.call(url),
            ),
            TextSpan(text: textList[1]),
          ],
          if (url == null) TextSpan(text: text),
        ],
      ),
    );
  }
}
