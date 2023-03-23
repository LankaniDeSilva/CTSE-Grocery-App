import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_constants.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(AssetsConstants.backIcon),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
