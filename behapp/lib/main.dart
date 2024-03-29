import 'package:behapp/firebase_options.dart';
import 'package:behapp/hiveCustomModel/user.dart';
import 'package:behapp/library/local_notification.dart';
import 'pages/page.dart';
import 'package:behapp/hiveCustomModel/hiveCustomModel.dart';
import 'providers/customprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<EmotionDiaryObject>('emotiondiary');
  await Hive.openBox<GoalObject>('goal');
  await Hive.openBox<TodoObject>('todo');
  await Hive.openBox<List<dynamic>>('todoprogress');
  await Hive.openBox<dynamic>('gamesetting');
  await Hive.openBox<User>('user');
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiProvider(
      providers: [
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
            builder: (context, child) => ResponsiveWrapper.builder(
                  BouncingScrollWrapper.builder(context, child!),
                  maxWidth: 1200,
                  minWidth: 450,
                  defaultScale: true,
                  breakpoints: [
                    const ResponsiveBreakpoint.resize(450, name: MOBILE),
                    const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                    const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                    const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                  ],
                ),
            debugShowCheckedModeBanner: false,
            home: PageBuilder(),
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'HiMelody',
              primarySwatch: Colors.blueGrey,
            ),
            routes: {
              DiaryPage.routeName: (context) => const DiaryPage(),
              DiaryWritePage.routeName: (context) => DiaryWritePage(),
              GoalsPage.routeName: (context) => GoalsPage(),
              GoalsWritePage.routeName: (context) => GoalsWritePage(),
            }),
      ),
    );
  }
}
