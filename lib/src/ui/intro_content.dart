import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroContent extends StatelessWidget {
  final PageViewModel page;
  final bool isFullScreen;

  const IntroContent({Key? key, required this.page, this.isFullScreen = false})
      : super(key: key);

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
          if (page.titleWidget != null || page.title != null)
            Padding(
              padding: page.decoration.titlePadding,
              child: _TextWidget(
                  widget: page.titleWidget,
                  text: page.title,
                  style: page.decoration.titleTextStyle,
                  textLines: page.decoration.titleLines),
            ),
          if (page.bodyWidget != null || page.body != null)
            Container(
              padding: page.decoration.bodyPadding,
              child: _TextWidget(
                  widget: page.bodyWidget,
                  text: page.body,
                  style: page.decoration.bodyTextStyle,
                  textLines: page.decoration.bodyLines),
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

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    required this.widget,
    required this.text,
    required this.style,
    required this.textLines,
  });

  final Widget? widget;
  final String? text;
  final TextStyle style;
  final int? textLines;

  @override
  Widget build(BuildContext context) {
    if (widget != null) {
      return widget!;
    }

    String text = this.text ?? '';
    int? maxLines;
    if (textLines != null) {
      text = text + '\n' * textLines!;
      maxLines = textLines;
    }
    return Text(text,
        style: style, textAlign: TextAlign.center, maxLines: maxLines);
  }
}
