import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroContent extends StatelessWidget {
  final PageViewModel page;
  final bool isFullScreen;

  const IntroContent({Key? key, required this.page, this.isFullScreen = false})
      : super(key: key);

  Widget _buildWidget(Widget? widget, String? text, TextStyle style,
      int? textLines) {
    if (widget != null) {
      return widget;
    }

    text = text ?? '';
    int? maxLines;
    if (textLines != null) {
      text = text + '\n'*textLines;
      maxLines = textLines;
    }
    return widget ?? Text(
        text, style: style, textAlign: TextAlign.center, maxLines: maxLines);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: page.decoration.contentMargin,
      decoration: isFullScreen
          ? page.decoration.boxDecoration ??
          BoxDecoration(
            color: page.decoration.pageColor,
            borderRadius: BorderRadius.circular(8.0),
          )
          : null,
      child: Column(
        children: [
          Padding(
            padding: page.decoration.titlePadding,
            child: _buildWidget(
              page.titleWidget,
              page.title,
              page.decoration.titleTextStyle,
              page.decoration.titleLines,
            ),
          ),
          Container(
            padding: page.decoration.bodyPadding,
            child: _buildWidget(
              page.bodyWidget,
              page.body,
              page.decoration.bodyTextStyle,
              page.decoration.bodyLines,
            ),
          ),
          if (page.footer != null)
            Padding(
              padding: page.decoration.footerPadding,
              child: page.footer,
            ),
        ],
      ),
    );
  }
}
