import 'package:behapp/firebase_options.dart';
import 'package:behapp/hivecustomobject/emotion_diary.dart';
import 'package:behapp/hivecustomobject/game_setting.dart';
import 'package:behapp/hivecustomobject/goal.dart';
import 'package:behapp/hivecustomobject/today_todo_progress.dart';
import 'package:behapp/hivecustomobject/todo.dart';
import 'package:behapp/library/local_notification.dart';
import 'package:behapp/pages/diary_page.dart';
import 'package:behapp/pages/diary_write_page.dart';
import 'package:behapp/pages/game_page.dart';
import 'package:behapp/pages/goals_page.dart';
import 'package:behapp/pages/goals_write_page.dart';
import 'package:behapp/pages/home_page.dart';
import 'package:behapp/providers/date_progress/date_progress_provider.dart';
import 'package:behapp/providers/emotion_diary/emotion_diary_provider.dart';
import 'package:behapp/providers/game_setting/game_setting_provider.dart';
// import 'package:behapp/providers/game_setting/game_setting_provider.dart';
import 'package:behapp/providers/goal/goal_provider.dart';

import 'package:behapp/providers/todo/todo_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmotionDiaryObjectAdapter());
  Hive.registerAdapter(EmotionAdapter());
  Hive.registerAdapter(GoalTypeAdapter());
  Hive.registerAdapter(GoalObjectAdapter());
  Hive.registerAdapter(TodoTypeAdapter());
  Hive.registerAdapter(TodoObjectAdapter());
  Hive.registerAdapter(TodayTodoProgressObjectAdapter());
  Hive.registerAdapter(GameSettingObjectAdapter());
  await Hive.openBox<EmotionDiaryObject>('emotiondiary');
  await Hive.openBox<GoalObject>('goal');
  await Hive.openBox<TodoObject>('todo');
  await Hive.openBox<List<dynamic>>('todoprogress');
  await Hive.openBox<GameSettingObject>('gamesetting');
  await initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    LocalNotification.initialize();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiProvider(
      providers: [
        StateNotifierProvider<GameSettingProvider, GameSettingState>(
          create: (context) => GameSettingProvider(),
        ),
        StateNotifierProvider<EmotionDiaryProvider, EmotionDiaryState>(
          create: (context) => EmotionDiaryProvider(),
        ),
        StateNotifierProvider<GoalProvider, GoalState>(
          create: (context) => GoalProvider(),
        ),
        StateNotifierProvider<DateProgressProvider, DateProgressState>(
          create: (context) => DateProgressProvider(),
        ),
        StateNotifierProvider<TodoProvider, TodoState>(
          create: (context) => TodoProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'HiMelody',
              primarySwatch: Colors.blueGrey,
            ),
            home: HomePage(),
            routes: {
              DiaryPage.routeName: (context) => const DiaryPage(),
              DiaryWritePage.routeName: (context) => DiaryWritePage(),
              GoalsPage.routeName: (context) => GoalsPage(),
              GoalsWritePage.routeName: (context) => GoalsWritePage(),
              GamePage.routeName: (context) => GamePage(),
            }),
      ),
    );
  }
}
