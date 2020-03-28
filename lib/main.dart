import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_riddles/pages/splashscreen.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/widget/app_builder.dart';
import 'package:provider/provider.dart';
import 'package:math_riddles/styles/theme.dart';
import 'package:math_riddles/providers/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final darkModeOn = await DB.getTheme();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(
        darkModeOn ? darkTheme : lightTheme,
      ),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return AppBuilder(
      builder: (context) => MaterialApp(
        title: 'Math Riddles - Infinite Math Challenges, Puzzles, Riddles',
        theme: themeNotifier.getTheme(),
        home: Splashscreen(),
      ),
    );
  }
}
