import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controllers/group_store.dart';
import 'controllers/expense_store.dart';
import 'theme/app_theme.dart';
import 'views/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF020617),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<GroupStore>(create: (_) => GroupStore()),
        Provider<ExpenseStore>(create: (_) => ExpenseStore()),
      ],
      child: const EmContaApp(),
    ),
  );
}

class EmContaApp extends StatelessWidget {
  const EmContaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Em Conta',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const MainShell(),
    );
  }
}
