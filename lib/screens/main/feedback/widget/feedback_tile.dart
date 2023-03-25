import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/models/objects.dart';
import 'package:grocery_app/provider/feedback/feedback_provider.dart';
import 'package:provider/provider.dart';

import '../../../../components/custom_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/assets_constants.dart';

class FeedbackTile extends StatelessWidget {
  const FeedbackTile({
    Key? key,
    required this.model,
  }) : super(key: key);

  final FeedbackModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: AppColors.kAsh.withOpacity(0.8),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 14, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: model.subject,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.kBlack,
              ),
              const SizedBox(height: 5),
              CustomText(
                text: model.message,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.kBlack,
              ),
              const SizedBox(height: 5),
              CustomText(
                text: model.reply!,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.kBlack,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () => {},
                        child: SvgPicture.asset(AssetsConstants.editIcon)),
                    const SizedBox(width: 15),
                    InkWell(
                        onTap: () => Provider.of<FeedbackProvider>(context, listen: false).removeFeedback(model.id, context),
                        child: SvgPicture.asset(AssetsConstants.deleteIcon)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
