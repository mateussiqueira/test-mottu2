import 'package:flutter/material.dart';

class AppSpacing {
  static const double none = 0;
  static const double xxxs = 2;
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
  static const double xxxl = 48;

  static const EdgeInsets zero = EdgeInsets.zero;

  static const EdgeInsets paddingXXXS = EdgeInsets.all(xxxs);
  static const EdgeInsets paddingXXS = EdgeInsets.all(xxs);
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);
  static const EdgeInsets paddingXXXL = EdgeInsets.all(xxxl);

  static const EdgeInsets horizontalXXXS =
      EdgeInsets.symmetric(horizontal: xxxs);
  static const EdgeInsets horizontalXXS = EdgeInsets.symmetric(horizontal: xxs);
  static const EdgeInsets horizontalXS = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSM = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMD = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLG = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXL = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets horizontalXXL = EdgeInsets.symmetric(horizontal: xxl);
  static const EdgeInsets horizontalXXXL =
      EdgeInsets.symmetric(horizontal: xxxl);

  static const EdgeInsets verticalXXXS = EdgeInsets.symmetric(vertical: xxxs);
  static const EdgeInsets verticalXXS = EdgeInsets.symmetric(vertical: xxs);
  static const EdgeInsets verticalXS = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSM = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMD = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLG = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXL = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsets verticalXXL = EdgeInsets.symmetric(vertical: xxl);
  static const EdgeInsets verticalXXXL = EdgeInsets.symmetric(vertical: xxxl);

  static const SizedBox verticalSpaceXXXS = SizedBox(height: xxxs);
  static const SizedBox verticalSpaceXXS = SizedBox(height: xxs);
  static const SizedBox verticalSpaceXS = SizedBox(height: xs);
  static const SizedBox verticalSpaceSM = SizedBox(height: sm);
  static const SizedBox verticalSpaceMD = SizedBox(height: md);
  static const SizedBox verticalSpaceLG = SizedBox(height: lg);
  static const SizedBox verticalSpaceXL = SizedBox(height: xl);
  static const SizedBox verticalSpaceXXL = SizedBox(height: xxl);
  static const SizedBox verticalSpaceXXXL = SizedBox(height: xxxl);

  static const SizedBox horizontalSpaceXXXS = SizedBox(width: xxxs);
  static const SizedBox horizontalSpaceXXS = SizedBox(width: xxs);
  static const SizedBox horizontalSpaceXS = SizedBox(width: xs);
  static const SizedBox horizontalSpaceSM = SizedBox(width: sm);
  static const SizedBox horizontalSpaceMD = SizedBox(width: md);
  static const SizedBox horizontalSpaceLG = SizedBox(width: lg);
  static const SizedBox horizontalSpaceXL = SizedBox(width: xl);
  static const SizedBox horizontalSpaceXXL = SizedBox(width: xxl);
  static const SizedBox horizontalSpaceXXXL = SizedBox(width: xxxl);

  static const double borderRadiusXXXS = xxxs;
  static const double borderRadiusXXS = xxs;
  static const double borderRadiusXS = xs;
  static const double borderRadiusSM = sm;
  static const double borderRadiusMD = md;
  static const double borderRadiusLG = lg;
  static const double borderRadiusXL = xl;
  static const double borderRadiusXXL = xxl;
  static const double borderRadiusXXXL = xxxl;

  static const BorderRadius roundedXXXS =
      BorderRadius.all(Radius.circular(borderRadiusXXXS));
  static const BorderRadius roundedXXS =
      BorderRadius.all(Radius.circular(borderRadiusXXS));
  static const BorderRadius roundedXS =
      BorderRadius.all(Radius.circular(borderRadiusXS));
  static const BorderRadius roundedSM =
      BorderRadius.all(Radius.circular(borderRadiusSM));
  static const BorderRadius roundedMD =
      BorderRadius.all(Radius.circular(borderRadiusMD));
  static const BorderRadius roundedLG =
      BorderRadius.all(Radius.circular(borderRadiusLG));
  static const BorderRadius roundedXL =
      BorderRadius.all(Radius.circular(borderRadiusXL));
  static const BorderRadius roundedXXL =
      BorderRadius.all(Radius.circular(borderRadiusXXL));
  static const BorderRadius roundedXXXL =
      BorderRadius.all(Radius.circular(borderRadiusXXXL));
}
