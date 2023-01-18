import 'package:behapp/firebase_options.dart';
import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/pages/diary_write_page.dart';
import 'package:behapp/pages/goals_page.dart';
import 'package:behapp/pages/goals_write_page.dart';
import 'package:behapp/pages/home_page.dart';
import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('emotiondiary');
  await Hive.openBox('goal');
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<EmotionDiaryProvider, EmotionDiaryState>(
          create: (context) => EmotionDiaryProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'HiMelody',
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
          routes: {
            DiaryPage.routeName: (context) => const DiaryPage(),
            DiaryWritePage.routeName: (context) => DiaryWritePage(),
            GoalsPage.routeName: (context) => GoalsPage(),
            GoalsWritePage.routeName: (context) => GoalsWritePage(),
          }),
    );
  }
}
