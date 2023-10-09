
import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/models/exam_paper_model.dart';
import 'package:quizzle/widgets/widgets.dart';

import '../../constants/constant.dart';

class ExamPaperCard extends GetView<ExamPaperController> {
  const ExamPaperCard({Key? key, required this.model}) : super(key: key);

  final ExamPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;

    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        borderRadius: UIParameters.cardBorderRadius,
        onTap: () {
          controller.navigateToQuestions(paper: model, context: context);
        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(clipBehavior: Clip.none, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: UIParameters.cardBorderRadius,
                  child: ColoredBox(
                      color: darkRed,
                      child: SizedBox(
                        width: 65,
                        height: 65,
                        child: model.imageUrl == null || model.imageUrl!.isEmpty
                            ? Image.asset(
                                "assets/images/TrackExamLogo.png",
                                height: 300,
                                width: 300,
                              )
                            : Image.network(model.imageUrl!),
                      )),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: GoogleFonts.bebasNeue(
                          fontSize: MediaQuery.of(context).size.width * 0.065,
                          color: darkRed),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(
                        model.description,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.030),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: EasySeparatedRow(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 15);
                        },
                        children: [
                          IconWithText(
                              icon: Icon(Icons.help_outline_sharp,
                                  color: Colors.blue[700]),
                              text: Text(
                                '${model.questionsCount} quizzes',
                                style: kDetailsTS.copyWith(
                                    color: Colors.blue[700]),
                              )),
                          IconWithText(
                              icon: const Icon(Icons.timer,
                                  color: Colors.blueGrey),
                              text: Text(
                                model.timeInMinits(),
                                style:
                                    kDetailsTS.copyWith(color: Colors.blueGrey),
                              )),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
