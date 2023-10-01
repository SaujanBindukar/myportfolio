import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/core/colors.dart';
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
    final project = ref.watch(projectController);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const HeaderText(label: 'Projects Involved'),
                const SizedBox(height: 5),
                const SubHeaderText(
                  label:
                      'Here are the beautiful mobile application projects that I have worked on',
                ),
                const SizedBox(height: 20),
                project.maybeWhen(
                  data: (value) {
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.length > 9 ? 9 : value.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.8,
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              launchUrl(
                                Uri.parse(value[index].projectLink),
                                webOnlyWindowName: '_blank',
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    value[index].projectImage,
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                                Text(
                                  value[index].projectName,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
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
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          const CustomSvg(
            path: 'assets/images/projects.svg',
          ),
        ],
      ),
    );
  }
}
