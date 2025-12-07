import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_tools_sharing/services/auth_service.dart';
import 'package:community_tools_sharing/services/supabase_service.dart';
import 'package:community_tools_sharing/utils/app_colors.dart';
import 'package:community_tools_sharing/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:community_tools_sharing/services/location_service.dart';
import 'package:community_tools_sharing/services/ocr_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompleteProfile extends StatefulWidget {
  final String email;
  final String password;

  const CompleteProfile({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _street = TextEditingController();
  final _apartment = TextEditingController();

  final _picker = ImagePicker();
  File? _frontId;
  File? _backId;
  String? _extractedIdNumber;
  String? _expiryDate;

  String? _lat;
  String? _lng;

  final _auth = FirebaseAuth.instance;
  final _authService = AuthService();
  final _supabaseService = SupabaseService();
  final _ocrService = OcrService();
  final _locationService = LocationService();

  bool _loading = false;

  // ---------------- LOCATION ----------------
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
      _showSnack(e.toString());
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
      _showSnack(e.toString());
    }
  }

  // ---------------- OCR ----------------
  Future<void> _pickImage(bool front) async {
    final img = await _picker.pickImage(source: ImageSource.camera);
    if (img == null) return;

    final file = File(img.path);
    setState(() {
      if (front) {
        _frontId = file;
      } else {
        _backId = file;
      }
    });

    if (front) await _extractIdData(file);
  }

  Future<void> _extractIdData(File imageFile) async {
    try {
      final data = await _ocrService.extractIdData(imageFile);
      final id = data['id'];
      final expiry = data['expiry'];

      if (id == null) {
        _showSnack('Could not read ID — please retake photo clearly');
      }

      setState(() {
        _extractedIdNumber = id;
        _expiryDate = expiry;
      });
    } catch (e) {
      _showSnack(e.toString());
    }
  }

  // ---------------- SUBMIT ----------------
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_frontId == null || _backId == null) {
      _showSnack('Please upload both sides of your ID');
      return;
    }

    setState(() => _loading = true);

    // ✅ Get email and password
    final email = widget.email;
    final password = widget.password;

    try {
      // ✅ Create Firebase user now
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // Upload images to Supabase
      final frontUrl = await _supabaseService.uploadUserIdImage(
        image: _frontId!,
        userId: uid,
        isFront: true,
      );

      final backUrl = await _supabaseService.uploadUserIdImage(
        image: _backId!,
        userId: uid,
        isFront: false,
      );

      // ✅ Save full profile data
      final data = {
        'firstName': _firstName.text.trim(),
        'lastName': _lastName.text.trim(),
        'phone': _phone.text.trim(),
        'address': _address.text.trim(),
        'city': _city.text.trim(),
        'street': _street.text.trim(),
        'apartment': _apartment.text.trim(),
        'latitude': _lat,
        'longitude': _lng,
        'nationalId': _extractedIdNumber,
        'idExpiry': _expiryDate,
        'frontIdUrl': frontUrl,
        'backIdUrl': backUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _authService.saveUserProfileData(uid, data);

      if (_expiryDate != null) {
        final exp = _expiryDate!;
        final year = int.tryParse(exp.split('/').last) ?? 0;
        if (year < DateTime.now().year) {
          _showSnack('Your ID appears expired — please renew it');
        }
      }

      _showSnack('Profile completed successfully ✅');
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      _showSnack(e.message ?? 'Registration failed');
    } catch (e) {
      _showSnack('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: size.height * 0.05,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.person_pin_circle_rounded,
                      size: size.width * 0.18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Complete Your Profile 🪪',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'We need some details to verify your identity',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),

              // FORM FIELDS
              _buildField(_firstName, 'First Name', TextInputType.name),
              _buildField(_lastName, 'Last Name', TextInputType.name),
              _buildField(_phone, 'Phone Number', TextInputType.phone),
              const SizedBox(height: 10),

              // ADDRESS + GPS
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _address,
                      decoration: const InputDecoration(
                        labelText: 'Search address or use GPS',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _searchPlaces,
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
              const SizedBox(height: 12),
              _buildField(_city, 'City', TextInputType.text),
              _buildField(_street, 'Street', TextInputType.text),
              _buildField(_apartment, 'Apartment', TextInputType.text),

              const SizedBox(height: 20),

              // ID IMAGES
              const Text(
                'Upload National ID',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _idCardWidget(true, _frontId),
                  _idCardWidget(false, _backId),
                ],
              ),
              const SizedBox(height: 16),
              if (_extractedIdNumber != null)
                Text('Detected ID: $_extractedIdNumber'),
              if (_expiryDate != null) Text('Expiry: $_expiryDate'),

              const SizedBox(height: 25),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Save & Continue',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController c,
    String label,
    TextInputType type,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) => v!.isEmpty ? 'Enter $label' : null,
      ),
    );
  }

  Widget _idCardWidget(bool front, File? file) {
    return GestureDetector(
      // onTap: () => _pickImage(front),
      child: Container(
        height: 100,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: file == null
            ? Center(
                child: Text(
                  front ? 'Front' : 'Back',
                  style: const TextStyle(color: Colors.black54),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(file, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
