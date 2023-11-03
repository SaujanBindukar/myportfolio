import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/core/colors.dart';
import 'package:myportfolio/core/navigator.dart';
import 'package:myportfolio/core/responsive_extensions.dart';
import 'package:myportfolio/core/widget/custom_svg.dart';
import 'package:myportfolio/feature/index_page.dart';

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
    final isMobile = context.isMobile;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 20 : 40,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hi, I am Saujan Bindukar!',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: AppColors.onPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'I develop mobile apps, web apps and websites using Flutter!',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: AppColors.onPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onHover: (value) {
                    setState(() {
                      isButtonHover = value;
                    });
                  },
                  onTap: () {
                    SectionNavigator.navigateToSections(
                      context: navigator[1].globalKey.currentContext!,
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
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 16 : 20,
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
          Expanded(
            child: CustomSvg(
              path: 'assets/images/intro1.svg',
              height: isMobile ? MediaQuery.of(context).size.height / 2 : null,
              width: isMobile ? MediaQuery.of(context).size.width : null,
            ),
          ),
        ],
      ),
    );
  }
}
