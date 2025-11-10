import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/faq_item.dart';

/// FAQ screen
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'What is Stay Human x Stay Humble?',
      'answer':
          'How do I change my subscription plan?\n\nStart by filling in the requested information. At best, this will only take a couple of minutes.\n\nYou can change your subscription plan anytime from the Account Settings. Just choose a plan that suits you.',
    },
    {
      'question': 'Do I need a cable subscription to use the app?',
      'answer': 'No, you don\'t need a cable subscription to use our app. All content is available through our streaming service.',
    },
    {
      'question': 'Can I watch on multiple devices?',
      'answer': 'Yes, you can watch on multiple devices simultaneously depending on your subscription plan.',
    },
    {
      'question': 'Can I watch content offline?',
      'answer': 'Yes, you can download content for offline viewing on supported devices.',
    },
    {
      'question': 'How can I cancel my subscription?',
      'answer': 'You can cancel your subscription anytime from the Account Settings under Subscription management.',
    },
    {
      'question': 'Will I be charged if I cancel my subscription?',
      'answer': 'No, you won\'t be charged after cancellation. You can continue using the service until the end of your billing period.',
    },
    {
      'question': 'Are there any ads on the app?',
      'answer': 'Our premium subscription is ad-free. Basic plans may include limited advertisements.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Faq',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return FaqItem(
            question: faqs[index]['question']!,
            answer: faqs[index]['answer']!,
          );
        },
      ),
    );
  }
}
