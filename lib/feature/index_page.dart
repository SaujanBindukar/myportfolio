import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/feature/about/about_page.dart';
import 'package:myportfolio/feature/contacts/contact_page.dart';
import 'package:myportfolio/feature/home/home_page.dart';
import 'package:myportfolio/feature/page_controller.dart';
import 'package:myportfolio/feature/projects/presentation/project_page.dart';
import 'package:myportfolio/feature/skills/skills_page.dart';

class IndexPage extends ConsumerStatefulWidget {
  const IndexPage({super.key});

  @override
  ConsumerState<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends ConsumerState<IndexPage> {
  final navigator = [
    'Home',
    'About',
    'Projects',
    'Skills',
    'Contact',
  ];
  @override
  Widget build(BuildContext context) {
    final pageController = ref.read(pageControllerProvider);
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
                    .map((e) => _NavigatorLabelButton(
                          pageController: pageController,
                          index: e.key,
                          label: e.value,
                        ))
                    .toList(),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.vertical,
              children: const [
                HomePage(),
                AboutPage(),
                ProjectPage(),
                SkillsPage(),
                ContactPage(),
              ],
            ),
          )
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
      ),
    );
  }
}

class _NavigatorLabelButton extends StatelessWidget {
  const _NavigatorLabelButton({
    required this.label,
    required this.index,
    required this.pageController,
  });

  final PageController pageController;
  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
