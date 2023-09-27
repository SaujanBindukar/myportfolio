import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
            ],
          ),
          SvgPicture.asset(
            'assets/images/intro1.svg',
            height: 400,
            allowDrawingOutsideViewBox: true,
          ),
        ],
      ),
    );
  }
}
