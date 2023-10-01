import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/core/widget/header_text.dart';
import 'package:myportfolio/feature/skills/controller/skill_controller.dart';

class SkillsPage extends ConsumerStatefulWidget {
  const SkillsPage({
    super.key,
  });

  @override
  ConsumerState<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends ConsumerState<SkillsPage> {
  @override
  Widget build(BuildContext context) {
    final skillData = ref.watch(skillController);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(
            child: CustomSvg(
              path: 'assets/images/skills.svg',
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HeaderText(label: 'My Skills'),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
    );
  }
}
