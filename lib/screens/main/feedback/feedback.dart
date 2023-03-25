import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/provider/feedback/feedback_provider.dart';
import 'package:grocery_app/screens/main/feedback/widget/feedback_tile.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 55),
              const CustomText(
                text: "Feedback",
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                        hintText: "Subject",
                        controller: Provider.of<FeedbackProvider>(context)
                            .subjectController),
                    const SizedBox(height: 18),
                    CustomTextField(
                        hintText: "Message",
                        controller: Provider.of<FeedbackProvider>(context)
                            .messageController),
                  ],
                ),
              ),

              const SizedBox(height: 18),
              Consumer<FeedbackProvider>(
                builder: (context, value, child) {
                  return CustomButton(
                      text: 'Add Feedback',
                      onTap: () => value.saveFeedbacks(context));
                },
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height,
                child:
                    Consumer<FeedbackProvider>(builder: (context, value, child) {
                  return value.feedback.isEmpty
                      ? const CustomText(
                          text: "No Feedbacks",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.kBlack,
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return FeedbackTile(
                              model: value.feedback[index],
                            );
                          },
                          itemCount: value.feedback.length,
                        );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
