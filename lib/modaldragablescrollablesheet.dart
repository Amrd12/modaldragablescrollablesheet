import 'package:flutter/material.dart';
part 'custom_bottom_sheet.dart';

class ModalDraggableScrollableSheet extends StatefulWidget {
  const ModalDraggableScrollableSheet({
    super.key,
    required this.screen,
    required this.scrollScreen,
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
    this.onSizeChanged, // Callback when size changes
    this.onSheetClosed, // Callback when the bottom sheet is closed
  });

  final Widget screen;
  final Widget Function(BuildContext context, ScrollController scrollController)
      scrollScreen;
  final double maxSize;
  final double minSize;
  final double initSize;
  final BorderRadius borderRadius;
  final Color bgcolor;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // Optional callbacks for more flexibility
  final void Function(double size)? onSizeChanged;
  final VoidCallback? onSheetClosed;

  @override
  State<ModalDraggableScrollableSheet> createState() =>
      _ModalDraggableScrollableSheetState();
}

class _ModalDraggableScrollableSheetState
    extends State<ModalDraggableScrollableSheet> {
  late DraggableScrollableController _controller;
  double height = 0.0;
  double get screenHeight => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
    _controller.addListener(_handleSizeChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(widget.initSize); // Set the initial position
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_handleSizeChange);
    super.dispose();
  }

  void _handleSizeChange() {
    final newSize = _controller.size;
    setState(() {
      height = newSize;
    });

    if (widget.onSizeChanged != null) {
      widget.onSizeChanged!(newSize); // Trigger the size change callback
    }

    if (newSize == widget.minSize && widget.onSheetClosed != null) {
      widget.onSheetClosed!(); // Trigger sheet closed callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Flexible(child: widget.screen),
            SizedBox(
              height: height * screenHeight,
            )
          ],
        ),
        _CustomBottomSheet(
          scrollController: _controller,
          maxSize: widget.maxSize,
          minSize: widget.minSize,
          initSize: widget.initSize,
          borderRadius: widget.borderRadius,
          bgcolor: widget.bgcolor,
          decoration: widget.decoration,
          padding: widget.padding,
          margin: widget.margin,
          screen: widget.scrollScreen,
        ),
      ],
    );
  }
}
