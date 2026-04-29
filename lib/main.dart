import 'package:countify/pages/count_itempage.dart';
import 'package:countify/pages/edit_countpage.dart';
import 'package:countify/pages/homepage.dart';
import 'package:countify/pages/settings_page.dart';
import 'package:countify/providers/count_provider.dart';
import 'package:countify/providers/setting_provider.dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create the provider instance
  final countProvider = CountProvider();
  // Load the saved data immediately
  await countProvider.loadData();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "countify app",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.light,
          ),
        ),
        routes: {
          '/': (context) => Homepage(),
          '/settings': (context) => SettingsPage(),
          '/count_item': (context) => ItemCountPage(),
          '/edit_count': (context) => EditCountPage(),
        },
        initialRoute: "/",
      ),
    );
  }
}
