import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/feature/skills/controller/skill_controller.dart';

class SkillsPage extends ConsumerStatefulWidget {
  const SkillsPage({super.key});

  @override
  ConsumerState<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends ConsumerState<SkillsPage> {
  @override
  Widget build(BuildContext context) {
    final skillData = ref.watch(skillController);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CustomSvg(
              path: 'assets/images/skills.svg',
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Skills',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: skillData.maybeWhen(
                      data: (value) {
                        return Wrap(
                          runSpacing: 30,
                          spacing: 30,
                          children: value
                              .map(
                                (e) => Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Text(
                                    e.trim(),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                      orElse: () => const SizedBox(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
