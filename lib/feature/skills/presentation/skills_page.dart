import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/responsive_extensions.dart';
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
    final isMobile = context.isMobile;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: isMobile ? 20 : 40,
      ),
      child: isMobile
          ? const Column(
              children: [
                HeaderText(label: 'My Skills'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CustomSvg(
                    path: 'assets/images/skills.svg',
                  ),
                ),
                _SkillsDataWidget(),
                SizedBox(height: 20),
              ],
            )
          : const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomSvg(
                    path: 'assets/images/skills.svg',
                  ),
                ),
                _SkillBody()
              ],
            ),
    );
  }
}

class _SkillBody extends ConsumerWidget {
  const _SkillBody();

  @override
  Widget build(BuildContext context, ref) {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeaderText(label: 'My Skills'),
          SizedBox(height: 40),
          _SkillsDataWidget()
        ],
      ),
    );
  }
}

class _SkillsDataWidget extends ConsumerWidget {
  const _SkillsDataWidget();

  @override
  Widget build(BuildContext context, ref) {
    final skillData = ref.watch(skillController);
    final isMobile = context.isMobile;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 40),
      child: skillData.maybeWhen(
        data: (value) {
          return Wrap(
            runSpacing: isMobile ? 30 : 30,
            spacing: isMobile ? 30 : 30,
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
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
    );
  }
}
