import 'package:flutter/material.dart';
import 'package:modaldragablescrollablesheet/modaldragablescrollablesheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DraggableScrollableController _controller;
  double height = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    _controller = DraggableScrollableController();
    _controller.addListener(changeSize);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(.3);
    });
    super.initState();
  }

  void changeSize() {
    setState(() {
      height = _controller.size;
    });
    // log(height.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ModalDraggableScrollableSheet(
            scrollController: _controller,
            screen: _screen(), // Main screen widget above the bottom sheet
            scrollScreen: (context, scrollController) =>
                _scrollScreen(scrollController),
            borderRadius: BorderRadius.circular(20),
            decoration: const BoxDecoration(
              color: Colors.red,
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
          ),
        ),
      ),
    );
  }

  ListView _scrollScreen(ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(
        title: Text('Item $index'),
      ),
    );
  }

  Container _screen() {
    return Container(
      color: Colors.green,
      height: double.maxFinite,
      width: double.maxFinite,
    );
  }
}
