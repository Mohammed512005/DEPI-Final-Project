import 'dart:io';
import 'package:community_tools_sharing/cubits/add_tool_cubit/add_tool_cubit.dart';
import 'package:community_tools_sharing/cubits/add_tool_cubit/add_tool_states.dart';
import 'package:community_tools_sharing/ui/models/tool_model.dart';
import 'package:community_tools_sharing/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:community_tools_sharing/services/location_service.dart';

class AddToolScreen extends StatefulWidget {
  const AddToolScreen({super.key});

  @override
  State<AddToolScreen> createState() => _AddToolScreenState();
}

class _AddToolScreenState extends State<AddToolScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final _address = TextEditingController();

  // Google Places API
  final _places = FlutterGooglePlacesSdk(
    'AIzaSyD8sfOw8pMudOe2AT_JlQw6ws1KxYzZ5ts',
  );

  String? _lat;
  String? _lng;
  final _locationService = LocationService();

  // ---------------- LOCATION ----------------
  Future<void> _getCurrentLocation() async {
    try {
      final pos = await _locationService.getCurrentLocation();
      setState(() {
        _lat = pos.latitude.toString();
        _lng = pos.longitude.toString();
        _address.text = 'Lat: ${_lat!}, Lng: ${_lng!}';
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }

  Future<void> _searchPlaces(String q) async {
    try {
      final result = await _locationService.searchPlace(q);
      if (result != null) {
        setState(() {
          _address.text = result['address'];
          _lat = result['lat']?.toString();
          _lng = result['lng']?.toString();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }

  // --- Form Variables ---
  File? _image;
  String? toolName;
  String? description;
  double? price;
  int? rentalPeriod;
  //String? location;
  String? category;
  String? condition;

  final categories = ['Power Tools', 'Hand Tools', 'Garden Tools', 'Other'];
  final conditions = ['New', 'Used'];

  Future<void> _pickImage() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      if (picked != null) {
        final File temporaryFile = File(picked.path);

        final appDir = await getApplicationDocumentsDirectory();
        final String fileName = p.basename(temporaryFile.path);
        final File permanentFile = await temporaryFile.copy(
          '${appDir.path}/$fileName',
        );

        setState(() => _image = permanentFile);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => AddToolCubit(),
      child: Scaffold(
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
                  // --- Image Picker ---
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
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 36,
                                  color: isDark
                                      ? Colors.blueAccent
                                      : const Color(0xFF009CDE),
                                ),
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

                  // --- Tool Name ---
                  _buildLabel('Tool Name'),
                  _buildTextField(
                    hint: 'Enter name',
                    onSaved: (v) => toolName = v,
                  ),

                  // --- Category ---
                  _buildLabel('Category'),
                  _buildDropdown(
                    hint: 'Select category',
                    value: category,
                    items: categories,
                    onChanged: (v) => setState(() => category = v),
                    onSaved: (v) => category = v,
                  ),

                  // --- Condition ---
                  _buildLabel('Condition'),
                  _buildDropdown(
                    hint: 'Select condition',
                    value: condition,
                    items: conditions,
                    onChanged: (v) => setState(() => condition = v),
                    onSaved: (v) => condition = v,
                  ),

                  // --- Description ---
                  _buildLabel('Description'),
                  _buildTextField(
                    hint: 'Write short description',
                    maxLines: 3,
                    onSaved: (v) => description = v,
                  ),

                  // --- Price ---
                  _buildLabel('Price / Day'),
                  _buildTextField(
                    hint: 'Enter price',
                    keyboardType: TextInputType.number,
                    onSaved: (v) => price = double.tryParse(v ?? '0'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Field is Required';
                      if (double.tryParse(v) == null)
                        return 'Enter valid number';
                      return null;
                    },
                  ),

                  // --- Rental Period ---
                  _buildLabel('Rental Period'),
                  _buildTextField(
                    hint: 'e.g. 2 days',
                    keyboardType: TextInputType.number,
                    onSaved: (v) => rentalPeriod = int.tryParse(v ?? '0'),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Field is Required';
                      if (int.tryParse(v) == null) return 'Enter valid number';
                      return null;
                    },
                  ),

                  //  --- Location ---
                  _buildLabel('Location'),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          hint: 'Enter Location',
                          onChanged: _searchPlaces,
                          controller: _address,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.my_location_rounded,
                          color: Colors.blue,
                        ),
                        onPressed: _getCurrentLocation,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // --- Submit Button ---
                  BlocConsumer<AddToolCubit, AddToolState>(
                    listener: (context, state) {
                      if (state is AddToolSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tool added successfully!'),
                          ),
                        );
                      } else if (state is AddToolError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: state is AddToolLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_image == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please pick an image'),
                                        ),
                                      );
                                      return;
                                    }

                                    _formKey.currentState!.save();

                                    final tool = ToolModel(
                                      image: _image!,
                                      toolName: toolName!,
                                      category: category!,
                                      condition: condition!,
                                      description: description!,
                                      price: price!,
                                      rentalPeriod: rentalPeriod!,

                                      latitude: _lat,
                                      longitude: _lng,
                                    );

                                    context.read<AddToolCubit>().addTool(tool);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF009CDE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state is AddToolLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Add Tool',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---
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

  Widget _buildTextField({
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
    TextEditingController? controller,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator:
          validator ??
          (v) => v == null || v.isEmpty ? 'Field is Required' : null,
      onSaved: onSaved,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEFF5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DropdownButtonFormField<String>(
      validator:
          validator ??
          (v) => v == null || v.isEmpty ? 'Field is Required' : null,
      value: value,
      isExpanded: true,
      dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEFF5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      hint: Text(
        hint,
        style: TextStyle(
          color: isDark ? Colors.grey[400] : Colors.grey[700],
          fontSize: 15,
        ),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
