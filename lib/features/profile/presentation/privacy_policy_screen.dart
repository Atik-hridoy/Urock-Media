import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Privacy Policy screen
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Effective Date: 26 Jan 2026',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'We value your privacy and are committed to protecting your personal information. By using our app, you agree to the following terms.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Information We Collect',
              [
                'Personal Info: Your name, email, payment details, and other info you provide.',
                'Usage Data: Information about how you use the app, device type, and preferences.',
              ],
            ),
            _buildSection(
              'How We Use Your Information',
              [
                'To provide and improve our services.',
                'To send you updates, recommendations, and promotions.',
                'To process your purchases and subscriptions.',
              ],
            ),
            _buildSection(
              'Sharing Your Information',
              [
                'With Service Providers: We may share data with trusted partners to help us operate the app.',
                'For Legal Reasons: If required by law or to protect our rights.',
              ],
            ),
            _buildSection(
              'Your Rights',
              [
                'You can access, update, or delete your personal information at any time.',
                'You can opt out of receiving notifications and manage preferences in the app settings.',
              ],
            ),
            _buildSection(
              'Security',
              [
                'We use secure methods to protect your information, but cannot guarantee complete security.',
              ],
            ),
            _buildSection(
              'Third-Party Links',
              [
                'Our app may link to other websites or services. We are not responsible for their privacy practices.',
              ],
            ),
            _buildSection(
              'Cookies',
              [
                'We use cookies to improve your app experience. You can manage them in your settings.',
              ],
            ),
            _buildSection(
              'Children\'s Privacy',
              [
                'Our app is not for children under 13. We do not knowingly collect data from children.',
              ],
            ),
            _buildSection(
              'Changes to This Policy',
              [
                'We may update this policy. Any changes will be reflected here.',
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}
