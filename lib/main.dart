import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nubank',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

    final svgPath = [
      'assets/svg/arrows.svg',
      'assets/svg/dollar.svg',
      'assets/svg/bag.svg',
    ].asMap();
    const kPrimaryColor = Color(0xFF820AD2);
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(color: Colors.white, height: 300),
                    Container(
                      height: 700,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage('assets/background.png'))),
                    ),
                    Container(color: Colors.white, height: 100),
                  ],
                ),
              ),
            ),
            BottomAppBar(
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: const Color(0xFFF0F1F5),
                      height: 3,
                    ),
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          height: 100,
                          color: Colors.white.withOpacity(.8),
                          child: ValueListenableBuilder(
                              valueListenable: currentIndex,
                              builder: (context, _, child) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: svgPath
                                      .map((index, path) => MapEntry(
                                          index,
                                          GestureDetector(
                                            onTap: () {
                                              currentIndex.value = index;
                                            },
                                            child: SvgPicture.asset(
                                              path,
                                              height: 23,
                                              color: currentIndex.value == index
                                                  ? kPrimaryColor
                                                  : const Color(0xFF8F919E),
                                            ),
                                          )))
                                      .values
                                      .toList(),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
