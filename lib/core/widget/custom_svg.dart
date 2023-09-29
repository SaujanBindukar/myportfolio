import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: 400,
      allowDrawingOutsideViewBox: true,
    );
  }
}
