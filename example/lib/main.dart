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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ModalDraggableScrollableSheet(
            screen: Container(
              color: Colors.green,
              height: double.maxFinite,
              width: double.maxFinite,
            ), // Main screen widget above the bottom sheet
            scrollScreen: (context, scrollController) => ListView.builder(
              controller: scrollController,
              itemCount: 100,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
              ),
            ),
            maxSize: 0.9,
            minSize: 0.1,
            initSize: 0.5,
            borderRadius: BorderRadius.circular(20),
            decoration: const BoxDecoration(
              color: Colors.red,
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            // onSizeChanged: (size) => print('Sheet size: $size'),
            // onSheetClosed: () => print('Sheet closed!'),
          ),
        ),
      ),
    );
  }
}
