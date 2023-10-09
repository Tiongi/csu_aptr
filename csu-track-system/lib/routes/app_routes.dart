import 'package:get/get.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/screens/exam/examSubjects_screen.dart';
import 'package:quizzle/screens/home/home_screen.dart';
import 'package:quizzle/screens/recommender/track_recommender.dart';
import 'package:quizzle/screens/screens.dart';

import '../main_page.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const SplashScreen(),
          name: "/",
        ),
        GetPage(
          page: () => const AppIntroductionScreen(),
          name: "/introduction",
        ),
        GetPage(
          name: "/mainpage",
          page: () => const MainPage(),
        ),
        GetPage(
          name: HomePage.routeName,
          page: () => const HomePage(),
        ),
        GetPage(
            page: () => const ExamScreen(),
            name: ExamScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<ExamController>(ExamController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const ExamOverviewScreen(),
            name: ExamOverviewScreen.routeName),
        GetPage(
            page: () => const ResultScreen(),
            name: ResultScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<ExamPaperController>(ExamPaperController());
            })),
        GetPage(
            page: () => const ExamSubjectsScreen(),
            name: ExamSubjectsScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(ExamPaperController());
            })),
        GetPage(
            page: () => const TrackRecommender(),
            name: TrackRecommender.routeName,
            binding: BindingsBuilder(() {
              Get.put(ExamPaperController());
            })),
      ];
}
