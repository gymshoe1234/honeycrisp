import 'package:flutter/material.dart';
import 'package:honeycrisp/features/main/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

//* Plugins: https://www.youtube.com/watch?v=VHhksMa2Ffg
//  - dart
//  - flutter (enable preview flutter ui guides ctrl+, search for 'guides')
//  - TabOut
//  - Pubspec Assist (shift+ctrl+, and search for 'pubs')
//  - Awesome Flutter Snippets
//  - Advanced New File (ctrl+alt+n)
//  - Bracket Pair Colorizer 2
//  - bloc (Felix Angelov)
//  - Todo Tree
//  - Better Comments
//  - Material Theme (darker)
//  - Material Icon Theme
//  - font: Fira Code | Victor Mono (and enable font ligatures in Settings)

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
