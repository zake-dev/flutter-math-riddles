import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/widget/app_builder.dart';
import 'package:provider/provider.dart';
import 'package:math_riddles/utils/connectivity.dart' as NetworkConnection;
import 'package:math_riddles/pages/home_page.dart';
import 'package:math_riddles/styles/theme.dart';
import 'package:math_riddles/providers/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NetworkConnection.check();
  final user = await DB.getUser();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(
        user.darkModeOn ? darkTheme : lightTheme,
      ),
      child: App(user),
    ),
  );
}

class App extends StatelessWidget {
  final user;

  App(this.user);

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
        home: HomePage(this.user),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
