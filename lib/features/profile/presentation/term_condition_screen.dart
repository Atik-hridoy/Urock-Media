import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:urock_media_movie_app/core/widgets/no_data.dart';
import 'package:urock_media_movie_app/features/profile/logic/profile_controller.dart';
import '../../../core/constants/app_colors.dart';

/// Privacy Policy screen
class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({super.key});

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  final _controller = ProfileController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.loadTerm();
  }

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
          'Term and Condition',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => _controller.terms.isEmpty
            ? NoData(
                onPressed: () => _controller.loadTerm(),
                text: "No term and condition found",
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Html(data: _controller.terms),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       'Effective Date: 26 Jan 2026',
                //       style: TextStyle(
                //         color: Colors.white.withOpacity(0.6),
                //         fontSize: 12,
                //       ),
                //     ),
                //     const SizedBox(height: 16),
                //     Text(
                //       'We value your privacy and are committed to protecting your personal information. By using our app, you agree to the following terms.',
                //       style: TextStyle(
                //         color: Colors.white.withOpacity(0.8),
                //         fontSize: 14,
                //         height: 1.5,
                //       ),
                //     ),
                //     const SizedBox(height: 24),
                //     _buildSection(
                //       'Information We Collect',
                //       [
                //         'Personal Info: Your name, email, payment details, and other info you provide.',
                //         'Usage Data: Information about how you use the app, device type, and preferences.',
                //       ],
                //     ),
                //     _buildSection(
                //       'How We Use Your Information',
                //       [
                //         'To provide and improve our services.',
                //         'To send you updates, recommendations, and promotions.',
                //         'To process your purchases and subscriptions.',
                //       ],
                //     ),
                //     _buildSection(
                //       'Sharing Your Information',
                //       [
                //         'With Service Providers: We may share data with trusted partners to help us operate the app.',
                //         'For Legal Reasons: If required by law or to protect our rights.',
                //       ],
                //     ),
                //     _buildSection(
                //       'Your Rights',
                //       [
                //         'You can access, update, or delete your personal information at any time.',
                //         'You can opt out of receiving notifications and manage preferences in the app settings.',
                //       ],
                //     ),
                //     _buildSection(
                //       'Security',
                //       [
                //         'We use secure methods to protect your information, but cannot guarantee complete security.',
                //       ],
                //     ),
                //     _buildSection(
                //       'Third-Party Links',
                //       [
                //         'Our app may link to other websites or services. We are not responsible for their privacy practices.',
                //       ],
                //     ),
                //     _buildSection(
                //       'Cookies',
                //       [
                //         'We use cookies to improve your app experience. You can manage them in your settings.',
                //       ],
                //     ),
                //     _buildSection(
                //       'Children\'s Privacy',
                //       [
                //         'Our app is not for children under 13. We do not knowingly collect data from children.',
                //       ],
                //     ),
                //     _buildSection(
                //       'Changes to This Policy',
                //       [
                //         'We may update this policy. Any changes will be reflected here.',
                //       ],
                //     ),
                //     const SizedBox(height: 24),
                //   ],
                // ),
              ),
      ),
    );
  }
}
