import 'package:flutter/material.dart';
part 'custom_bottom_sheet.dart';

class ModalDraggableScrollableSheet extends StatelessWidget {
  const ModalDraggableScrollableSheet({
    super.key,
    required this.screen,
    required this.scrollScreen,
    required this.scrollController, // Added controller parameter
    this.maxSize = 1.0, // Max height when fully expanded
    this.minSize = 0.1, // Min height when collapsed
    this.initSize = 0.5, // Initial height
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(50),
      topRight: Radius.circular(50),
    ),
    this.bgcolor = Colors.transparent, // Background color of the bottom sheet
    this.decoration,
    this.padding, // Custom padding if needed
    this.margin, // Custom margin if needed
  });

  final Widget screen;
  final Widget Function(BuildContext context, ScrollController scrollController)
      scrollScreen;
  final DraggableScrollableController
      scrollController; // Changed to accept controller
  final double maxSize;
  final double minSize;
  final double initSize;
  final BorderRadius borderRadius;
  final Color bgcolor;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    double height = scrollController.size;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            screen,
            SizedBox(
              height: height * screenHeight,
            )
          ],
        ),
        _CustomBottomSheet(
          scrollController: scrollController,
          maxSize: maxSize,
          minSize: minSize,
          initSize: initSize,
          borderRadius: borderRadius,
          bgcolor: bgcolor,
          decoration: decoration,
          padding: padding,
          margin: margin,
          screen: scrollScreen,
        ),
      ],
    );
  }
}
