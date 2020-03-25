import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_riddles/widget/app_builder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:math_riddles/pages/home_page.dart';
import 'package:math_riddles/styles/theme.dart';
import 'package:math_riddles/providers/theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    final darkModeOn = prefs.getBool('darkMode') ?? true;

    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (context) => ThemeNotifier(
          darkModeOn ? darkTheme : lightTheme,
        ),
        child: App(),
      ),
    );
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: themeNotifier.getTheme().accentColorBrightness,
    ));

    return AppBuilder(
      builder: (context) => MaterialApp(
        title: 'Math Riddles - Infinite Math Challenges, Puzzles, Riddles',
        theme: themeNotifier.getTheme(),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
