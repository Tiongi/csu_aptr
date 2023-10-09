import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/constants/constant.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/main_page.dart';
import 'package:quizzle/widgets/widgets.dart';

import '../../widgets/cards/exam_paper_card.dart';

class ExamSubjectsScreen extends StatelessWidget {
  const ExamSubjectsScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    ExamPaperController _quizePprContoller = Get.find();

    return WillPopScope(
      onWillPop: () async {
        // Return true to allow the user to exit the app, or false to prevent it.
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
              onPressed: () {
                Navigator.of(context).pushNamed(MainPage.routeName);
              }),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(kMobileScreenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Reminder:',
                          style: GoogleFonts.bebasNeue(
                              fontSize: MediaQuery.of(context).size.width * 0.1,
                              color: darkRed)),
                    ),
                    Text('Timer will start once you take the exam',
                        style: GoogleFonts.bebasNeue(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.055)),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ContentArea(
                    addPadding: false,
                    child: Obx(
                      () => LiquidPullToRefresh(
                        height: 150,
                        springAnimationDurationInMilliseconds: 500,
                        //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        color: darkRed,
                        onRefresh: () async {
                          _quizePprContoller.getAllPapers();
                        },
                        child: ListView.separated(
                          padding: UIParameters.screenPadding,
                          shrinkWrap: true,
                          itemCount: _quizePprContoller.allPapers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ExamPaperCard(
                              model: _quizePprContoller.allPapers[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
