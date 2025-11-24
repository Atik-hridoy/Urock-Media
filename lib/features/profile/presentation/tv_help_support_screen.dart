import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';

/// TV-optimized Help & Support screen with D-pad navigation
class TvHelpSupportScreen extends StatefulWidget {
  const TvHelpSupportScreen({super.key});

  @override
  State<TvHelpSupportScreen> createState() => _TvHelpSupportScreenState();
}

class _TvHelpSupportScreenState extends State<TvHelpSupportScreen> {
  final FocusNode _mainFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _subjectFocusNode = FocusNode();
  final FocusNode _messageFocusNode = FocusNode();
  final FocusNode _sendButtonFocusNode = FocusNode();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  int _selectedFieldIndex = 0;
  final List<FocusNode> _fieldFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _fieldFocusNodes.addAll([
      _nameFocusNode,
      _emailFocusNode,
      _subjectFocusNode,
      _messageFocusNode,
      _sendButtonFocusNode,
    ]);
  }

  @override
  void dispose() {
    _mainFocusNode.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    for (final focusNode in _fieldFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveScale.init(context);
    final double maxWidth = ResponsiveScale.maxContentWidth.clamp(800.0, 1000.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: KeyboardListener(
          focusNode: _mainFocusNode,
          autofocus: true,
          onKeyEvent: _handleKeyEvent,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingXL,
                  vertical: AppSizes.paddingLG,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTopBar(context),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildHeader(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildForm(),
                    const SizedBox(height: AppSizes.spacingXL),
                    _buildSendButton(),
                    const SizedBox(height: AppSizes.spacingXL),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: ResponsiveScale.iconSize(24),
          ),
        ),
        const SizedBox(width: AppSizes.spacingMD),
        Text(
          'Help & Support',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveScale.fontSize(24),
              ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
          },
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: ResponsiveScale.iconSize(24),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Support Icon
        Container(
          width: ResponsiveScale.width(100),
          height: ResponsiveScale.height(100),
          decoration: BoxDecoration(
            color: AppColors.goldLight.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.goldLight,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.support_agent,
            color: AppColors.goldLight,
            size: ResponsiveScale.iconSize(48),
          ),
        ),
        const SizedBox(height: AppSizes.spacingLG),
        Text(
          'How can we help you?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveScale.fontSize(20),
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Text(
          'Have a question or need assistance?\nReach out to our support team, and we\'ll get back to you as soon as possible.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontSize: ResponsiveScale.fontSize(16),
                height: 1.5,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildTextField(
            label: 'Name',
            controller: _nameController,
            hint: 'Enter your name',
            focusNode: _nameFocusNode,
            isSelected: _selectedFieldIndex == 0,
            onTap: () => _selectField(0),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          _buildTextField(
            label: 'Email',
            controller: _emailController,
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            isSelected: _selectedFieldIndex == 1,
            onTap: () => _selectField(1),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          _buildTextField(
            label: 'Subject',
            controller: _subjectController,
            hint: 'What\'s your inquiry about?',
            focusNode: _subjectFocusNode,
            isSelected: _selectedFieldIndex == 2,
            onTap: () => _selectField(2),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          _buildTextField(
            label: 'Message',
            controller: _messageController,
            hint: 'Tell us how we can assist you',
            maxLines: 4,
            focusNode: _messageFocusNode,
            isSelected: _selectedFieldIndex == 3,
            onTap: () => _selectField(3),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required FocusNode focusNode,
    required bool isSelected,
    required VoidCallback onTap,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.goldLight : Colors.white,
              fontSize: ResponsiveScale.fontSize(14),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: isSelected 
                  ? AppColors.goldLight.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
              border: Border.all(
                color: isSelected 
                    ? AppColors.goldLight
                    : Colors.white.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              focusNode: focusNode,
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveScale.fontSize(14),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: ResponsiveScale.fontSize(14),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingSM,
                  vertical: AppSizes.paddingSM,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return GestureDetector(
      onTap: () {
        _selectField(4);
        _sendMessage();
      },
      child: Container(
        width: ResponsiveScale.width(250),
        height: ResponsiveScale.height(50),
        decoration: BoxDecoration(
          color: _selectedFieldIndex == 4 
              ? AppColors.goldDark
              : AppColors.goldLight,
          borderRadius: BorderRadius.circular(AppSizes.radiusSM),
          boxShadow: [
            BoxShadow(
              color: AppColors.goldLight.withOpacity(0.3),
              blurRadius: _selectedFieldIndex == 4 ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.send,
                color: Colors.black,
                size: ResponsiveScale.iconSize(18),
              ),
              const SizedBox(width: 4),
              Text(
                'Send',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ResponsiveScale.fontSize(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectField(int index) {
    setState(() {
      _selectedFieldIndex = index;
    });
    // Only request focus for text fields (0-3), not for send button (4)
    if (index < 4) {
      _fieldFocusNodes[index].requestFocus();
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          if (_selectedFieldIndex > 0) {
            _selectField(_selectedFieldIndex - 1);
          }
          break;
        case LogicalKeyboardKey.arrowDown:
          if (_selectedFieldIndex < _fieldFocusNodes.length - 1) {
            _selectField(_selectedFieldIndex + 1);
          }
          break;
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.select:
          if (_selectedFieldIndex == 4) {
            _sendMessage();
          } else {
            _fieldFocusNodes[_selectedFieldIndex].requestFocus();
          }
          break;
        case LogicalKeyboardKey.escape:
          Navigator.pop(context);
          break;
      }
    }
  }

  void _sendMessage() {
    // Validate fields
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _subjectController.text.trim().isEmpty ||
        _messageController.text.trim().isEmpty) {
      _showErrorDialog();
      return;
    }

    // Show success dialog
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 40,
                ),
              ),
              const SizedBox(height: 32),
              // Title
              const Text(
                'Message Sent Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Message
              Text(
                'We\'ll get back to you within 24 hours.\nThank you for contacting us!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              // OK Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldLight,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(height: 32),
              // Title
              const Text(
                'Please fill all fields',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              // Message
              const Text(
                'All fields are required. Please complete the form before sending.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              // OK Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldLight,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
