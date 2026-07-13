import 'package:emvigo_machine_task/constants/app_constants.dart';
import 'package:emvigo_machine_task/controllers/auth_bloc/auth_repository.dart';
import 'package:emvigo_machine_task/models/user_model.dart';
import 'package:emvigo_machine_task/views/home_page.dart';
import 'package:emvigo_machine_task/widgets/k_filled_button.dart';
import 'package:emvigo_machine_task/widgets/k_text_form_field.dart';
import 'package:flutter/material.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  // Controllers for form inputs.
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _languageController = TextEditingController();

  // Form state and validation key.
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  String? _selectedGender;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _nationalityController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  // Opens a date picker and stores the selected date in the DOB field.
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  // Validates the form and saves the profile details through the repository.
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final repository = AuthRepository();
      final userModel = UserModel(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        dob: DateTime.tryParse(_dobController.text) ?? DateTime.now(),
        gender: _selectedGender ?? '',
        nationality: _nationalityController.text.trim(),
        language: _languageController.text.trim(),
        email: '',
        password: '',
      );

      await repository.saveProfile(userModel);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save profile: $e')));
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Create your Profile',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: dmSerifDisplay,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Create your profile with some basic information'),
                  const SizedBox(height: 40),

                  // Name section.
                  const Text("What's your name?"),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: KTextFormField(
                          hintText: 'First',
                          controller: _firstNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: KTextFormField(
                          hintText: 'Last',
                          controller: _lastNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Date of birth section.
                  const Text("What's your date of birth?"),
                  const SizedBox(height: 8),
                  KTextFormField(
                    hintText: 'dd/mm/yyyy',
                    controller: _dobController,
                    readOnly: true,
                    onTap: _pickDate,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please select date of birth';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Gender selection section.
                  const Text("What's your gender?"),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: ['Male', 'Female'].map((gender) {
                      final isSelected = _selectedGender == gender;
                      return ChoiceChip(
                        label: Text(gender),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => _selectedGender = gender);
                        },
                      );
                    }).toList(),
                  ),
                  if (_selectedGender == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Please select your gender',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Nationality section.
                  const Text("What's your nationality?"),
                  const SizedBox(height: 8),
                  KTextFormField(
                    hintText: 'Eg: Indian',
                    controller: _nationalityController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your nationality';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Language section.
                  const Text('Language spoken'),
                  const SizedBox(height: 8),
                  KTextFormField(
                    hintText: 'Eg: English',
                    controller: _languageController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your language';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Submit button for saving the profile.
                  KFilledButton(
                    onPressed: _isSaving ? () {} : _saveProfile,
                    text: _isSaving ? 'SAVING...' : 'SAVE',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
