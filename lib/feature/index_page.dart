import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/navigator.dart';
import 'package:myportfolio/feature/about/about_page.dart';
import 'package:myportfolio/feature/contacts/contact_page.dart';
import 'package:myportfolio/feature/home/home_page.dart';
import 'package:myportfolio/feature/projects/presentation/project_page.dart';
import 'package:myportfolio/feature/skills/presentation/skills_page.dart';

final navigator = [
  NavHeaderItem(
    name: 'Home',
    globalKey: GlobalKey(),
  ),
  NavHeaderItem(
    name: 'About',
    globalKey: GlobalKey(),
  ),
  NavHeaderItem(
    name: 'Projects',
    globalKey: GlobalKey(),
  ),
  NavHeaderItem(
    name: 'Skills',
    globalKey: GlobalKey(),
  ),
  NavHeaderItem(
    name: 'Contact',
    globalKey: GlobalKey(),
  ),
];

class NavHeaderItem {
  final String name;
  final GlobalKey globalKey;

  NavHeaderItem({
    required this.name,
    required this.globalKey,
  });
}

class IndexPage extends ConsumerStatefulWidget {
  const IndexPage({super.key});

  @override
  ConsumerState<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends ConsumerState<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                const MySignature(),
                const Expanded(
                  child: SizedBox(),
                ),
                ...navigator
                    .asMap()
                    .entries
                    .map(
                      (e) => _NavigatorLabelButton(
                        index: e.key,
                        label: e.value.name,
                        globalKey: e.value.globalKey,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomePage(key: navigator[0].globalKey),
                  AboutPage(key: navigator[1].globalKey),
                  ProjectPage(key: navigator[2].globalKey),
                  SkillsPage(key: navigator[3].globalKey),
                  ContactPage(key: navigator[4].globalKey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MySignature extends StatelessWidget {
  const MySignature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Saujan Bindukar',
      style: GoogleFonts.dancingScript(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimaryColor,
      ),
    );
  }
}

class _NavigatorLabelButton extends ConsumerWidget {
  const _NavigatorLabelButton(
      {required this.label, required this.index, required this.globalKey});

  final int index;
  final String label;
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () {
        SectionNavigator.navigateToSections(
          context: navigator[index].globalKey.currentContext!,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.onPrimaryColor,
          ),
        ),
      ),
    );
  }
}
