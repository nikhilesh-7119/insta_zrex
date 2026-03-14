import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/theme/app_theme.dart';
import 'controllers/feed_controller.dart';
import 'controllers/story_controller.dart';
import 'views/home/home_screen.dart';

void main() {
  runApp(const InstaApp());
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedController>(() => FeedController());
    Get.lazyPut<StoryController>(() => StoryController());
  }
}

class InstaApp extends StatelessWidget {
  const InstaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: AppBindings(),
      home: const HomeScreen(),
    );
  }
}
