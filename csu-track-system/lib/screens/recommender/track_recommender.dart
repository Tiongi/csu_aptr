import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/configs/themes/ui_parameters.dart';
import 'package:quizzle/firebase/references.dart';
import 'package:quizzle/main_page.dart';
import 'package:quizzle/models/exam_paper_model.dart';
import 'package:quizzle/widgets/common/content_area.dart';
import '../../constants/constant.dart';

class TrackRecommender extends StatefulWidget {
  const TrackRecommender({Key? key}) : super(key: key);

  static const String routeName = '/trackrecommender';

  @override
  _TrackRecommenderState createState() => _TrackRecommenderState();
}

class _TrackRecommenderState extends State<TrackRecommender> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  bool _resultsVisible = false;
  bool _recommendationsShown = false;
  List<Map<String, dynamic>> _userDocs = [];

  final Map<String, String> paperIdLabels = {
    'ppr001': 'Programming',
    'ppr002': 'Web Development',
    'ppr003': 'Networking',
    'ppr004': 'Business Intelligence',
    'ppr005': 'Enterprise Systems',
    'ppr006': 'Mathematics for IT',
    'ppr007': 'Communications for IT',
    'ppr008': 'Data Science',
    'ppr009': 'BPO'
    // Add more mappings as needed
  };

  @override
  void initState() {
    super.initState();
    // Automatically show track recommendations when the screen is opened
    showTrackRecommendation();
  }

  CollectionReference<Map<String, dynamic>> getSubmittedAnswers(
          String userId) =>
      FirebaseFirestore.instance
          .collection('submitted_answers')
          .doc(userId)
          .collection('exams');

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
      _resultsVisible = false;
    });

    try {
      final email = user.email!;
      final collectionReference = getSubmittedAnswers(email);
      final querySnapshot = await collectionReference.get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDataList =
            querySnapshot.docs.map((doc) => doc.data()).toList();
        setState(() {
          _userDocs = userDataList;
          _resultsVisible = true;
        });
      } else {
        setState(() {
          _resultsVisible = false;
        });
      }
    } catch (e) {
      // Handle any errors that may occur during data retrieval.
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String getPaperLabel(String paperId) {
    return paperIdLabels[paperId] ?? paperId;
  }

  void showTrackRecommendation() {
    // Step 1: Initialize variables for major and minor subjects
    int programmingSubjectTotalCorrect = 0;
    int webDevelopmentSubjectTotalCorrect = 0;
    int networkingSubjectTotalCorrect = 0;
    int businessIntelligenceSubjectTotalCorrect = 0;
    int enterpriceSystemsSubjecttTotalCorrect = 0;
    int minorSubjectsTotalCorrect = 0;
/*    int programmingSubjectTotalQuestions =
        0; // Initialize totalQuestions variables
    int webDevelopmentSubjectTotalQuestions = 0;
    int networkingSubjectTotalQuestions = 0;

    // Define a map to store the correct count for each subject
    Map<String, int> subjectCorrectCounts = {};

    for (final userData in _userDocs) {
      final paperId = userData['paper_id'] as String;
      final correctCount = userData['correct_count'] as String;

      // Parse the correct count from the format 'result/total questions'
      final parts = correctCount.split('/');
      if (parts.length == 2) {
        final result = int.tryParse(parts[0]);
        final totalQuestions = int.tryParse(parts[1]);

        if (result != null && totalQuestions != null && totalQuestions > 0) {
          // Update the correct count for the subject
          subjectCorrectCounts[paperId] = result;

          // Categorize subjects into major or minor based on your criteria
          if (['ppr001'].contains(paperId)) {
            // Major Subjects
            programmingSubjectTotalCorrect += result;
            programmingSubjectTotalQuestions +=
                totalQuestions; // Increment totalQuestions
          }
          if (['ppr002'].contains(paperId)) {
            // Major Subjects
            webDevelopmentSubjectTotalCorrect += result;
            webDevelopmentSubjectTotalQuestions +=
                totalQuestions; // Increment totalQuestions
          }
          if (['ppr003'].contains(paperId)) {
            // Major Subjects
            networkingSubjectTotalCorrect += result;
            networkingSubjectTotalQuestions +=
                totalQuestions; // Increment totalQuestions
          } else if (['ppr004', 'ppr005', 'ppr006', 'ppr007']
              .contains(paperId)) {
            // Minor Subjects
            minorSubjectsTotalCorrect += result;
          }
        }
      }
    }
 */
    // Step 2: Calculate percentages for major and minor subjects

    double minorSubjectsPercentage = (minorSubjectsTotalCorrect / 4) * 0.3;

    // Step 3: Determine priority tracks based on percentages
    String topPriorityTrack = '';
    String highPriorityTrack = '';
    String moderatePriorityTrack = '';
    String lessPriorityTrack = '';
    String additionalPriorityTrack = '';

    // Modify this part to define your own priority logic
    if (programmingSubjectTotalCorrect > webDevelopmentSubjectTotalCorrect &&
        programmingSubjectTotalCorrect > networkingSubjectTotalCorrect) {
      topPriorityTrack = 'Programming Track';
      if (webDevelopmentSubjectTotalCorrect > networkingSubjectTotalCorrect) {
        moderatePriorityTrack = 'Web Development Track';
        lessPriorityTrack = 'Networking Track';
      } else {
        moderatePriorityTrack = 'Networking Track';
        lessPriorityTrack = 'Web Development Track';
      }
    } else if (webDevelopmentSubjectTotalCorrect >
            programmingSubjectTotalCorrect &&
        webDevelopmentSubjectTotalCorrect > networkingSubjectTotalCorrect) {
      topPriorityTrack = 'Web Development Track';
      if (programmingSubjectTotalCorrect > networkingSubjectTotalCorrect) {
        moderatePriorityTrack = 'Programming Track';
        lessPriorityTrack = 'Networking Track';
      } else {
        moderatePriorityTrack = 'Networking Track';
        lessPriorityTrack = 'Programming Track';
      }
    } else {
      topPriorityTrack = 'Networking Track';
      if (programmingSubjectTotalCorrect > webDevelopmentSubjectTotalCorrect) {
        moderatePriorityTrack = 'Programming Track';
        lessPriorityTrack = 'Web Development Track';
      } else {
        moderatePriorityTrack = 'Web Development Track';
        lessPriorityTrack = 'Programming Track';
      }
    }

    // Step 4: Display the recommendations
    setState(() {
      _topPriorityTrack = topPriorityTrack;
      _highPriorityTrack = highPriorityTrack;
      _moderatePriorityTrack = moderatePriorityTrack;
      _lessPriorityTrack = lessPriorityTrack;
      _additionalPriorityTrack = additionalPriorityTrack;
      _recommendationsShown = true; // Mark recommendations as shown
    });
  }

  // Define variables to hold the track recommendations
  String _topPriorityTrack = '';
  String _highPriorityTrack = '';
  String _moderatePriorityTrack = '';
  String _lessPriorityTrack = '';
  String _additionalPriorityTrack = '';

  Widget _buildRecommendationContainer() {
    if (_topPriorityTrack.isNotEmpty ||
        _moderatePriorityTrack.isNotEmpty ||
        _lessPriorityTrack.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: darkRed, // Change the background color to darkRed
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*  Text(
              'Track Recommendations',
              style: GoogleFonts.bebasNeue(
                fontSize: MediaQuery.of(context).size.width * 0.050,
                color: Colors.white, // Text color is white
              ),
            ), */
            const SizedBox(height: 10),
            Text(
              'Top Priority: $_topPriorityTrack',
              style: GoogleFonts.bebasNeue(
                fontSize: MediaQuery.of(context).size.width * 0.050,
                color: Colors.white, // Text color is violet
              ),
            ),
            Text(
              'Moderate Priority: $_moderatePriorityTrack',
              style: GoogleFonts.bebasNeue(
                fontSize: MediaQuery.of(context).size.width * 0.050,
                color: Colors.white, // Text color is violet
              ),
            ),
            Text(
              'Less Priority: $_lessPriorityTrack',
              style: GoogleFonts.bebasNeue(
                fontSize: MediaQuery.of(context).size.width * 0.050,
                color: Colors.white, // Text color is violet
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(); // Return an empty container if there are no recommendations
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.of(context).pushNamed(MainPage.routeName);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(kMobileScreenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Track Recommendation',
                      style: GoogleFonts.bebasNeue(
                        fontSize: MediaQuery.of(context).size.width * 0.1,
                        color: violet,
                      ),
                    ),
                  ),
                  Text(
                    'Disclaimer:',
                    style: GoogleFonts.bebasNeue(
                      color: darkRed,
                      fontSize: MediaQuery.of(context).size.width * 0.050,
                    ),
                  ),
                  Text(
                    'The tracks recommended by the system is determined by your examination results and does not imply mandatory enrollment in the top-priority track.',
                    style: GoogleFonts.bebasNeue(
                      fontSize: MediaQuery.of(context).size.width * 0.040,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_resultsVisible) {
                  setState(() {
                    _resultsVisible = false;
                  });
                } else {
                  fetchData();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: darkRed, // Dark red background color
              ),
              child: Text(
                _resultsVisible ? 'Hide Results' : 'Fetch Data',
                style: GoogleFonts.bebasNeue(
                  color: Colors.white, // Text color is white
                ),
              ),
            ),
            if (_isLoading)
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(darkRed),
              )
            else if (_resultsVisible && _userDocs.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    _buildRecommendationContainer(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Expanded(
                          child: ContentArea(
                            child: ListView.separated(
                              itemCount: _userDocs.length,
                              separatorBuilder: (context, index) =>
                                  const Spacer(),
                              itemBuilder: (context, index) {
                                final userData = _userDocs[index];
                                final paperId = userData['paper_id'] as String;
                                final paperLabel = getPaperLabel(paperId);

                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: yellow,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Subject: $paperLabel',
                                        style: GoogleFonts.bebasNeue(
                                          color: violet,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.050,
                                        ),
                                      ),
                                      Text(
                                        'Correct Answers: ${userData['correct_count']}',
                                        style: GoogleFonts.bebasNeue(
                                          color: violet,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.040,
                                        ),
                                      ),
                                      Text(
                                        'Time: ${userData['time']}',
                                        style: GoogleFonts.bebasNeue(
                                          color: darkRed,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else if (!_isLoading)
              Text(
                _resultsVisible
                    ? 'No results are available yet.'
                    : 'Click the button to fetch data.',
                style: GoogleFonts.bebasNeue(
                  color: darkRed,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
