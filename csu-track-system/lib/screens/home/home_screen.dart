import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/ui/glass_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/constant.dart';
import '../../firebase/references.dart';
import '../verifications/exam_result_permission.dart';
import '../verifications/examinee_verification_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homescreen";

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;

  TabController? tabController;
  int index = 0;

  void _tabListener() {
    setState(() {
      index = tabController!.index;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    tabController?.addListener(_tabListener);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.removeListener(_tabListener);
    tabController!.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width * 0.95;
    final isSmallScreen = screenWidth <= 600;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: yellow),
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.menu, color: violet),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                  backgroundColor: yellow,
                  expandedHeight: 280,
                  floating: false,
                  pinned: true,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 30.0),
                    child: FlexibleSpaceBar(
                      background: Text(
                        "Get to know \nabout CICS",
                        style: GoogleFonts.bebasNeue(
                            fontSize: screenHeight * 0.070,
                            color: violet,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

                //this is the tab section
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: lightVioGradient,
                            borderRadius: BorderRadius.circular(20)),
                        child: TabBar(
                            indicatorPadding: const EdgeInsets.all(10),
                            controller: tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              gradient: primGradient,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Tab(
                                  icon: Icon(Icons.book),
                                  text: 'Tracks',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Tab(
                                  icon: Icon(Icons.info),
                                  text: 'About Us',
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                )
              ];
            },
            // THIS IS THE ABOUT US TAB SECTION
            body: TabBarView(controller: tabController, children: [
              //THIS IS THE COURSE TAB SECTION

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  decoration: const BoxDecoration(
                      color: violet,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(
                        16), // Add some padding for spacing
                    children: [
                      tracksTile(
                        title: 'Programming',
                        subtitle:
                            'Programming involves writing instructions for computers to execute tasks. It is the foundation of software development.',
                        color: Colors.blue, // Customize the color
                      ),
                      subjectsTile(
                          title: 'Subjects',
                          subtitle:
                              '1. Desktop Application Development, \n2. Advance Pyhon Programming, \n3. Mobile App Development, \n4. Advance Java \n5. PowerBi',
                          color: Colors.white),
                      tracksTile(
                        title: 'Networking',
                        subtitle:
                            'Networking is the practice of connecting computers and other devices to share resources and information. It is essential for modern communication and internet access.',
                        color: Colors.green, // Customize the color
                      ),
                      subjectsTile(
                          title: 'Subjects',
                          subtitle:
                              '1. Ethical Hacking/ System Administration, \n2. Cyber Security, \n3. Network Operating Systems, \n4. Firewalls and Intrusion Detection System',
                          color: Colors.white),
                      tracksTile(
                        title: 'Web Development',
                        subtitle:
                            'Web Development involves creating websites and web applications. It encompasses various technologies and skills for building interactive and responsive web experiences.',
                        color: Colors.orange, // Customize the color
                      ),
                      subjectsTile(
                          title: 'Subjects',
                          subtitle:
                              '1. Web Programming, \n2. Web Interactivity and Engagement, \n3. Advance Web Programming, \n4. Mobile App Development \n5. Project Management Analytics',
                          color: Colors.white),
                      tracksTile(
                        title: 'Business Intelligence',
                        subtitle:
                            'A Business Intelligence (BI) track is a field in IT and data management that focuses on using data to inform decision-making. It involves collecting, analyzing, and presenting data for strategic planning and operational improvements.',
                        color: Colors.purple, // Customize the color
                      ),
                      subjectsTile(
                          title: 'Subjects',
                          subtitle:
                              '1. Microsoft PowerBi, \n2. Systems Applications and Products in Data Processing (SAP), \n3. Statistical Analysis Systems (SAS), \n4. Oracle Analytics',
                          color: Colors.white),
                      tracksTile(
                        title: 'Enterprise Systems',
                        subtitle:
                            'An Enterprise Systems track is a specialized pathway in information technology that focuses on designing, implementing, and managing integrated software systems for large organizations.',
                        color: Colors.red, // Customize the color
                      ),
                      subjectsTile(
                          title: 'Subjects',
                          subtitle:
                              '1. Enterprise Resource Planning (ERP), \n2. Supply Chain Management (SCM), \n3. Customer Relationship Management (CRM), \n4. Key Management Service (KMS)',
                          color: Colors.white),
                      tracksTile(
                        title: 'Data Science',
                        subtitle:
                            'Data Science involves extracting insights and knowledge from data through various techniques, including data analysis, machine learning, and statistical modeling.',
                        color: Colors.purple, // Customize the color
                      ),
                      tracksTile(
                        title: 'BPO',
                        subtitle:
                            'Business Process Outsourcing (BPO) involves contracting specific business processes to external service providers. It helps organizations streamline operations and reduce costs.',
                        color: Colors.red, // Customize the color
                      ),
                    ],
                  ),
                ),
              ),
              ListView(shrinkWrap: true, children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        height: screenHeight,
                        width: screenWidth,
                        decoration: const BoxDecoration(
                            color: darkRed,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 40.0,
                              left: screenWidth * 0.05,
                              right: screenWidth * 0.05),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Flexible(
                                        flex: 2,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: 'Mission & Vision',
                                              style: GoogleFonts.sora(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: yellow),
                                            ),
                                            TextSpan(
                                              text:
                                                  '\nOur app is dedicated to guiding users toward their ideal educational and career paths. Our vision is to empower individuals with personalized recommendations that align with their skills, interests, and aspirations, ensuring a brighter future.',
                                              style: GoogleFonts.sora(
                                                  fontSize: screenWidth * 0.03,
                                                  color: Colors.white),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Flexible(
                                        flex: 2,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: 'Core Values',
                                              style: GoogleFonts.sora(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: yellow),
                                            ),
                                            TextSpan(
                                              text:
                                                  '\n We uphold the values of accuracy and data privacy. Rest assured that your information is handled with the utmost care, and our recommendations are based on reliable data and the latest industry insights.',
                                              style: GoogleFonts.sora(
                                                  fontSize: screenWidth * 0.03,
                                                  color: Colors.white),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Flexible(
                                        flex: 2,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: 'Acknowledgement',
                                              style: GoogleFonts.sora(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: yellow),
                                            ),
                                            TextSpan(
                                              text:
                                                  "\nWe are proud to collaborate with leading educational institutions, career advisors, and industry experts to enhance the quality of our recommendations. Our partnerships with [Institution/Expert Names] have helped shape the app's credibility.",
                                              style: GoogleFonts.sora(
                                                  fontSize: screenWidth * 0.03,
                                                  color: Colors.white),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Flexible(
                                        flex: 2,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: 'Team',
                                              style: GoogleFonts.sora(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: yellow),
                                            ),
                                            TextSpan(
                                              text:
                                                  "\nOur app is the result of the collaborative efforts of a dedicated team of capstone project students. Led by Jayson M. Cartagena, and with the valuable contributions of Kit Clein John A. Padre and Fraiden Lee A. Maruquin, we embarked on this educational journey to create a tool that empowers individuals in making informed choices about their educational and career paths. Our project is not only a testament to our commitment to academic excellence but also a reflection of our passion for helping you shape a brighter future.",
                                              style: GoogleFonts.sora(
                                                  fontSize: screenWidth * 0.03,
                                                  color: Colors.white),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                            text: 'Contact Information',
                                            style: GoogleFonts.sora(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: yellow),
                                          ),
                                          TextSpan(
                                            text:
                                                "\nHave questions, feedback, or need assistance? Feel free to reach out to us at [csuaptr@email.com]. We're also active on social media, so connect with us on [social media handles] for updates and news.",
                                            style: GoogleFonts.sora(
                                                fontSize: screenWidth * 0.03,
                                                color: Colors.white),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ]),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FrostedGlassDrawer(
              child: ListView(
                shrinkWrap: true,
                children: [
                  DrawerHeader(
                    child: Image.asset(
                      'assets/images/TrackExamLogo.png',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        '2023 Cagayan State University Aparri Campus Maintained by CICS Management',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: violet),
                    child: ListTile(
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.quiz_rounded, color: Colors.white),
                      ),
                      title: Text(
                        'Examination',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ExamineeVerificationScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: violet),
                    child: ListTile(
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child:
                            Icon(Icons.checklist_rounded, color: Colors.white),
                      ),
                      title: Text(
                        'Results',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ResultPermissionScreen()),
                        );
                      },
                    ),
                  ),
                  /*               const SizedBox(
                    height: 15,
                  ), */
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: primGradient,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: MaterialButton(
                            onPressed: () {
                              _launchURL("http://aparri.csu.edu.ph/");
                            },
                            color: violet,
                            child: const Icon(
                              Icons.facebook_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "CSU-Aparri Campus",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            color: violet,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: primGradient,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: MaterialButton(
                              onPressed: () {
                                //put hylink for facebook
                              },
                              color: violet,
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                              )),
                        ),
                        Text(
                          "(078) 888-0786 \n(078) 888-0562",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            color: violet,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: primGradient,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: MaterialButton(
                              onPressed: () {
                                //put hylink for facebook
                              },
                              color: violet,
                              child: const Icon(
                                Icons.location_on_rounded,
                                color: Colors.white,
                              )),
                        ),
                        Text(
                          "Maura, Aparri, Cagayan",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 15,
                            color: violet,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: violet,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Logged in as ${user.email}",
                          style: GoogleFonts.bebasNeue(
                            fontSize: screenWidth * 0.050,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MaterialButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          color: darkRed,
                          child: Text(
                            'Sign out',
                            style: GoogleFonts.bebasNeue(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tracksTile({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      title: Text(
        title,
        style: GoogleFonts.pacifico(
          fontSize: MediaQuery.of(context).size.width * 0.060,
          color: yellow, // Text color
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.sora(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          color: Colors.white, // Text color
        ),
      ),
      tileColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  Widget subjectsTile({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.bebasNeue(
          fontSize: 15,
          color: Colors.white, // Text color
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.sora(
          fontSize: MediaQuery.of(context).size.width * 0.03,
          color: Colors.white, // Text color
        ),
      ),
      tileColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
