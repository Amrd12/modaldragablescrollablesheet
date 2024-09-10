part of 'modaldragablescrollablesheet.dart';

class _CustomBottomSheet extends StatelessWidget {
  final DraggableScrollableController scrollController;
  final double maxSize, minSize, initSize;
  final BorderRadius borderRadius;
  final Color bgcolor;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget Function(BuildContext context, ScrollController scrollController)
      screen;

  const _CustomBottomSheet({
    super.key,
    required this.scrollController,
    required this.maxSize,
    required this.minSize,
    required this.initSize,
    required this.screen,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(50),
      topRight: Radius.circular(50),
    ),
    this.bgcolor = Colors.transparent,
    this.decoration,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: scrollController,
      initialChildSize: initSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: margin ?? EdgeInsets.zero, // Apply margin if provided
          child: DecoratedBox(
            decoration: decoration ??
                BoxDecoration(
                  color: bgcolor,
                  borderRadius: borderRadius,
                ),
            child: Padding(
              padding:
                  padding ?? EdgeInsets.all(0), // Apply padding if provided
              child: screen(context, scrollController),
            ),
          ),
        );
      },
    );
  }
}
