import 'package:countify/pages/count_itempage.dart';
import 'package:countify/pages/edit_countpage.dart';
import 'package:countify/pages/homepage.dart';
import 'package:countify/pages/settings_page.dart';
import 'package:countify/providers/count_provider.dart';
import 'package:countify/providers/setting_provider.dart';
import 'package:countify/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

  final countProvider = CountProvider();
  await countProvider.loadData();

  runApp(
    MyApp(settingsProvider: settingsProvider, countProvider: countProvider),
  );
}

class MyApp extends StatelessWidget {
  final SettingsProvider settingsProvider;
  final CountProvider countProvider;

  const MyApp({
    super.key,
    required this.settingsProvider,
    required this.countProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsProvider),
        ChangeNotifierProxyProvider<SettingsProvider, CountProvider>(
          create: (context) => countProvider,
          update: (context, settings, count) {
            count!.update(settings);
            return count;
          },
        ),
      ],
      builder: (newContext, child) {
        final isDark = newContext.watch<SettingsProvider>().isDarkThemeEnabled;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "countify app",
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(
          //     seedColor: Colors.teal,
          //     brightness: isDark ? Brightness.dark : Brightness.light,
          //   ),
          // ),
          theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
          routes: {
            '/': (context) => const Homepage(),
            '/settings': (context) => const SettingsPage(),
            '/count_item': (context) => const ItemCountPage(),
            '/edit_count': (context) => const EditCountPage(),
          },
          initialRoute: "/",
        );
      },
    );
  }
}
