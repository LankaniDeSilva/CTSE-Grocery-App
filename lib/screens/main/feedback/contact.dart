import 'package:flutter/material.dart';
import 'package:grocery_app/components/custom_text.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  static const _email = 'support@groceryapp.com';
  static const _phoneNumber = '+1 123-456-7890';
  static const _website = 'https://www.groceryapp.com';

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _email,
      queryParameters: {
        'subject': 'Support Request',
        'body': 'Please enter your message here',
      },
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  Future<void> _callPhoneNumber() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: _phoneNumber,
    );

    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch phone';
    }
  }

  Future<void> _openWebsite() async {
    final Uri websiteUri = Uri.parse(_website);

    if (await canLaunch(websiteUri.toString())) {
      await launch(websiteUri.toString());
    } else {
      throw 'Could not launch website';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Contact Us',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.kBlack,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Get in touch with us',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 24),
              _buildContactOption(
                'Email',
                _email,
                Icons.email_outlined,
                _sendEmail,
              ),
              const SizedBox(height: 16),
              _buildContactOption(
                'Phone',
                _phoneNumber,
                Icons.phone_outlined,
                _callPhoneNumber,
              ),
              const SizedBox(height: 16),
              _buildContactOption(
                'Website',
                _website,
                Icons.language_outlined,
                _openWebsite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactOption(
    String label,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
         
