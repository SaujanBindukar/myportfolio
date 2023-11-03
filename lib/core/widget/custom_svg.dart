import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    super.key,
    required this.path,
    this.height,
    this.width,
  });
  final String path;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height ?? MediaQuery.of(context).size.width / 3,
      width: width ?? MediaQuery.of(context).size.width / 3,
      allowDrawingOutsideViewBox: true,
    );
  }
}
