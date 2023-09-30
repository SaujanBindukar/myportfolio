import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/feature/page_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isButtonHover = false;
  @override
  Widget build(BuildContext context) {
    final pageController = ref.read(pageControllerProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi, I am Saujan Bindukar!',
              style: GoogleFonts.montserrat(
                fontSize: 24,
              ),
            ),
            Text(
              'I develop mobile apps, web apps and websites using Flutter!',
              style: GoogleFonts.montserrat(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onHover: (value) {
                setState(() {
                  isButtonHover = value;
                });
              },
              onTap: () {
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
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
                  'Know More',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color:
                        isButtonHover ? Colors.white : AppColors.primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
        const CustomSvg(
          path: 'assets/images/intro1.svg',
        ),
      ],
    );
  }
}
