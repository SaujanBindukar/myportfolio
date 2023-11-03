import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/responsive_extensions.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/core/widget/header_text.dart';
import 'package:myportfolio/feature/projects/repository/project_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectPage extends ConsumerStatefulWidget {
  const ProjectPage({
    super.key,
  });

  @override
  ConsumerState<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends ConsumerState<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: isMobile
          ? Stack(
              children: [
                Opacity(
                  opacity: 0.05,
                  child: CustomSvg(
                    path: 'assets/images/projects.svg',
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                const _ProjectBody(),
              ],
            )
          : const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: _ProjectBody()),
                SizedBox(width: 40),
                CustomSvg(
                  path: 'assets/images/projects.svg',
                ),
              ],
            ),
    );
  }
}

class _ProjectBody extends StatelessWidget {
  const _ProjectBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        HeaderText(label: 'Projects Involved'),
        SizedBox(height: 5),
        SubHeaderText(
          label:
              'Here are the beautiful mobile application projects that I have worked on',
        ),
        SizedBox(height: 20),
        _ProjectView()
      ],
    );
  }
}

class _ProjectView extends ConsumerWidget {
  const _ProjectView();

  @override
  Widget build(BuildContext context, ref) {
    final isMobile = context.isMobile;
    final project = ref.watch(projectController);
    return project.maybeWhen(
      data: (value) {
        return GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: value.length > 9 ? 9 : value.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: isMobile ? 1 : 1.7,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  await FirebaseAnalytics.instance.logEvent(
                    name: value[index].projectName,
                  );
                  launchUrl(
                    Uri.parse(value[index].projectLink),
                    webOnlyWindowName: '_blank',
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        value[index].projectImage,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Text(
                      value[index].projectName,
                      textAlign: TextAlign.center,
                      // maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.onPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              );
            });
      },
      loading: () {
        return const Center(
            child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ));
      },
      error: (error, stackTrace) => Text(error.toString()),
      orElse: () => const SizedBox(),
    );
  }
}
