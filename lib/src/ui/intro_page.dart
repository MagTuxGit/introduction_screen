import 'package:flutter/material.dart';
import 'package:introduction_screen/src/helper.dart';
import 'package:introduction_screen/src/model/page_view_model.dart';
import 'package:introduction_screen/src/ui/intro_content.dart';

class IntroPage extends StatefulWidget {
  final PageViewModel page;
  final ScrollController? scrollController;
  final bool isTopSafeArea;
  final bool isBottomSafeArea;

  const IntroPage({
    Key? key,
    required this.page,
    this.scrollController,
    required this.isTopSafeArea,
    required this.isBottomSafeArea,
  }) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.page.decoration.fullScreen) {
      return _StackIntroContent(widget.page, widget.scrollController);
    }
    return SafeArea(
      top: widget.isTopSafeArea,
      bottom: widget.isBottomSafeArea,
      child: _FlexIntroContent(widget.page, widget.scrollController),
    );
  }
}

class _StackIntroContent extends StatelessWidget {
  final PageViewModel page;
  final ScrollController? scrollController;

  const _StackIntroContent(this.page, this.scrollController);

  @override
  Widget build(BuildContext context) {
    final content = IntroContent(page: page, isFullScreen: true);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (page.image != null) page.image!,
        Positioned.fill(
          child: Column(
            children: [
              ...[
                Spacer(flex: page.decoration.imageFlex),
                Expanded(
                  flex: page.decoration.bodyFlex,
                  child: page.useScrollView
                      ? SingleChildScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: content,
                        )
                      : content,
                ),
              ].asReversed(page.reverse),
              const SafeArea(top: false, child: SizedBox(height: 60.0)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlexIntroContent extends StatelessWidget {
  final PageViewModel page;
  final ScrollController? scrollController;

  const _FlexIntroContent(this.page, this.scrollController);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      color: page.decoration.pageColor,
      decoration: page.decoration.boxDecoration,
      margin: const EdgeInsets.only(bottom: 60.0),
      child: Flex(
        direction:
            page.useRowInLandscape && orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (page.image != null)
            Expanded(
              flex: page.decoration.imageFlex,
              child: Align(
                alignment: page.decoration.imageAlignment,
                child: Padding(
                  padding: page.decoration.imagePadding,
                  child: page.image,
                ),
              ),
            ),
          Expanded(
            flex: page.decoration.bodyFlex,
            child: Align(
              alignment: page.decoration.bodyAlignment,
              child: page.useScrollView
                  ? SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: IntroContent(page: page),
                    )
                  : IntroContent(page: page),
            ),
          ),
        ].asReversed(page.reverse),
      ),
    );
  }
}
