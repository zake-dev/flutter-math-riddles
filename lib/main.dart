import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:math_riddles/pages/home_page.dart';
import 'package:math_riddles/styles/theme.dart';
import 'package:math_riddles/providers/theme_notifier.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(darkTheme),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(MaterialLocalizations.of(context));
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Math Riddles - Infinite Math Challenges, Puzzles, Riddles',
      theme: themeNotifier.getTheme(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
