import 'package:appwrite/appwrite.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/core/appwrite_client.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/core/widget/header_text.dart';
import 'package:myportfolio/feature/about/about_controller.dart';

import 'dart:html' as html;

import 'package:myportfolio/utils/appwrite_utils.dart';

class AboutPage extends ConsumerStatefulWidget {
  const AboutPage({
    super.key,
  });

  @override
  ConsumerState<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends ConsumerState<AboutPage> {
  bool isButtonHover = false;
  @override
  Widget build(BuildContext context) {
    final client = ref.read(appwriteClient);
    final about = ref.watch(aboutController);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CustomSvg(
            path: 'assets/images/about.svg',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HeaderText(label: 'About Me'),
                  const SizedBox(height: 20),
                  about.when(
                    data: (value) {
                      final data = value;
                      return Text(
                        data,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: AppColors.onPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        isButtonHover = value;
                      });
                    },
                    onTap: () async {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'resume_download',
                      );
                      final database = Databases(client);
                      final result = await database.getDocument(
                        databaseId: AppwriteUtils.databaseId,
                        collectionId: '6518394e0387478c7022',
                        documentId: '651839752992bb1cd974',
                      );
                      final url = result.data['resumeLink'].toString();
                      html.AnchorElement anchorElement =
                          html.AnchorElement(href: url);
                      anchorElement.download = url;
                      anchorElement.click();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isButtonHover ? AppColors.primaryColor : null,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: Text(
                        'Download Resume',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: isButtonHover
                              ? Colors.white
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
