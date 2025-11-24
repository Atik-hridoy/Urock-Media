import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/responsive_scale.dart';

/// TV-optimized Edit Profile screen with D-pad navigation
class TvEditProfileScreen extends StatefulWidget {
  const TvEditProfileScreen({super.key});

  @override
  State<TvEditProfileScreen> createState() => _TvEditProfileScreenState();
}

class _TvEditProfileScreenState extends State<TvEditProfileScreen> {
  final FocusNode _mainFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _saveButtonFocusNode = FocusNode();
  
  final TextEditingController _nameController = TextEditingController(text: 'Alexandar');
  final TextEditingController _usernameController = TextEditingController(text: 'Alexandar12');
  final TextEditingController _emailController = TextEditingController(text: 'Alexandar12@gmail.com');
  
  int _selectedFieldIndex = 0;
  final List<FocusNode> _fieldFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _fieldFocusNodes.addAll([
      _nameFocusNode,
      _usernameFocusNode,
      _emailFocusNode,
      _saveButtonFocusNode,
    ]);
  }

  @override
  void dispose() {
    _mainFocusNode.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
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
                    _buildSaveButton(),
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
          'Edit Profile',
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
        // Profile Picture with Edit Button
        Stack(
          children: [
            Container(
              width: ResponsiveScale.width(100),
              height: ResponsiveScale.height(100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.goldLight.withOpacity(0.4),
                    AppColors.goldDark.withOpacity(0.4),
                  ],
                ),
                border: Border.all(color: AppColors.goldLight, width: 2),
              ),
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white70,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // TODO: Implement profile picture change
                },
                child: Container(
                  width: ResponsiveScale.width(32),
                  height: ResponsiveScale.height(32),
                  decoration: BoxDecoration(
                    color: AppColors.goldLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.background,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: ResponsiveScale.iconSize(16),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spacingLG),
        Text(
          'Edit Your Profile',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveScale.fontSize(20),
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spacingMD),
        Text(
          'Update your personal information\nand keep your profile fresh',
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
            icon: Icons.person_outline,
            focusNode: _nameFocusNode,
            isSelected: _selectedFieldIndex == 0,
            onTap: () => _selectField(0),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          _buildTextField(
            label: 'Username',
            controller: _usernameController,
            icon: Icons.alternate_email,
            focusNode: _usernameFocusNode,
            isSelected: _selectedFieldIndex == 1,
            onTap: () => _selectField(1),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          _buildTextField(
            label: 'Email',
            controller: _emailController,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            isSelected: _selectedFieldIndex == 2,
            onTap: () => _selectField(2),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required FocusNode focusNode,
    required bool isSelected,
    required VoidCallback onTap,
    TextInputType keyboardType = TextInputType.text,
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
                  : const Color(0xFF2C2C2C),
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
              focusNode: focusNode,
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveScale.fontSize(14),
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: isSelected 
                      ? AppColors.goldLight
                      : Colors.white.withOpacity(0.5),
                  size: ResponsiveScale.iconSize(20),
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

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () {
        _selectField(3);
        _saveChanges();
      },
      child: Container(
        width: ResponsiveScale.width(250),
        height: ResponsiveScale.height(50),
        decoration: BoxDecoration(
          color: _selectedFieldIndex == 3 
              ? AppColors.goldDark
              : AppColors.goldLight,
          borderRadius: BorderRadius.circular(AppSizes.radiusSM),
          boxShadow: [
            BoxShadow(
              color: AppColors.goldLight.withOpacity(0.3),
              blurRadius: _selectedFieldIndex == 3 ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.save,
                color: Colors.black,
                size: ResponsiveScale.iconSize(18),
              ),
              const SizedBox(width: 4),
              Text(
                'Save',
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
    // Only request focus for text fields (0-2), not for save button (3)
    if (index < 3) {
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
          if (_selectedFieldIndex == 3) {
            _saveChanges();
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

  void _saveChanges() {
    // Validate fields
    if (_nameController.text.trim().isEmpty ||
        _usernameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty) {
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
                'Profile Updated Successfully!',
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
                'Your profile information has been\nupdated successfully.',
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
                'All fields are required. Please complete the form before saving.',
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
