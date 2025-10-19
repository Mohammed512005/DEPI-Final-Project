import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:community_tools_sharing/utils/app_style.dart';

class AddToolScreen extends StatefulWidget {
  const AddToolScreen({super.key});

  @override
  State<AddToolScreen> createState() => _AddToolScreenState();
}

class _AddToolScreenState extends State<AddToolScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  String? selectedCategory;
  String? selectedCondition;
  bool isFree = false;
  File? _image;

  final categories = ['Power Tools', 'Hand Tools', 'Garden Tools', 'Other'];
  final conditions = ['New', 'Used'];

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final periodController = TextEditingController();
  final locationController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (picked != null) setState(() => _image = File(picked.path));
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    periodController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0D0D) : Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add Tool',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// --- Image Picker ---
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E1E1E)
                          : const Color(0xFFE8EFF2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.grey.shade700
                            : const Color(0xFFBFD5E2),
                      ),
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined,
                                  size: 36,
                                  color: isDark
                                      ? Colors.blueAccent
                                      : const Color(0xFF009CDE)),
                              const SizedBox(height: 10),
                              Text(
                                'Add photo',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.blueAccent
                                      : const Color(0xFF009CDE),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 24),

                /// --- Tool Name ---
                _buildLabel('Tool Name'),
                _buildTextField(controller: nameController, hint: 'Enter name'),

                /// --- Category ---
                _buildLabel('Category'),
                _buildDropdown(
                  hint: 'Select category',
                  value: selectedCategory,
                  items: categories,
                  onChanged: (v) => setState(() => selectedCategory = v),
                ),

                /// --- Condition ---
                _buildLabel('Condition'),
                _buildDropdown(
                  hint: 'Select condition',
                  value: selectedCondition,
                  items: conditions,
                  onChanged: (v) => setState(() => selectedCondition = v),
                ),

                /// --- Description ---
                _buildLabel('Description'),
                _buildTextField(
                  controller: descController,
                  hint: 'Write short description',
                  maxLines: 3,
                ),

                /// --- Price ---
                _buildLabel('Price / Day'),
                _buildTextField(
                  controller: priceController,
                  hint: 'Enter price',
                  keyboardType: TextInputType.number,
                ),

                /// --- Rental Period ---
                _buildLabel('Rental Period'),
                _buildTextField(
                  controller: periodController,
                  hint: 'e.g. 2 days',
                ),

                /// --- Location ---
                _buildLabel('Location'),
                _buildTextField(
                  controller: locationController,
                  hint: 'Enter location',
                ),

                const SizedBox(height: 28),

                /// --- Submit Button ---
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: integrate Firebase/Firestore logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tool added successfully!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009CDE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add Tool',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// --- Reusable label ---
  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 14),
        child: Text(
          label,
          style: AppStyle.mainTextStyle.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// --- Reusable text field ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor:
            isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEFF5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  /// --- Reusable dropdown ---
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEFF5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      hint: Text(
        hint,
        style: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[700],
          fontSize: 15,
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
