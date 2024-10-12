import 'package:flutter/material.dart';
import 'package:hms_system_application/widgets/outlined_text_input.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Initial field values
  String initialFirstName = 'John';
  String initialLastName = 'Doe';
  String initialEmail = 'johndoe@example.com';
  String initialContact = '0123456789';

  // Controllers to handle the input
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  bool _isDataChanged = false;
  bool _isContactValid = true; // Flag to track contact validation

  @override
  void initState() {
    super.initState();
    // Set initial values to controllers
    _firstNameController.text = initialFirstName;
    _lastNameController.text = initialLastName;
    _emailController.text = initialEmail;
    _contactController.text = initialContact;

    // Add listeners to detect changes in the text fields
    _firstNameController.addListener(_checkForChanges);
    _lastNameController.addListener(_checkForChanges);
    _contactController.addListener(_checkForChanges);
  }

  // Check if the data has been changed
  void _checkForChanges() {
    if (_firstNameController.text != initialFirstName ||
        _lastNameController.text != initialLastName ||
        _contactController.text != initialContact) {
      setState(() {
        _isDataChanged = true;
      });
    } else {
      setState(() {
        _isDataChanged = false;
      });
    }

    // Validate contact number
    _validateContact(_contactController.text);
  }

  // Validate the contact number (starts with '0' and is 10 characters long)
  void _validateContact(String value) {
    if (value.startsWith('0') && value.length == 10) {
      setState(() {
        _isContactValid = true;
      });
    } else {
      setState(() {
        _isContactValid = false;
      });
    }
  }

  // Save changes function with confirmation dialog
  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      // Check if the form is valid
      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Save'),
            content: const Text('Are you sure you want to save changes?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      if (confirm) {
        setState(() {
          initialFirstName = _firstNameController.text;
          initialLastName = _lastNameController.text;
          initialContact = _contactController.text;
          _isDataChanged = false; // Reset after saving
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes saved successfully!')),
        );
      }
    }
  }

  // Reset form data
  void _resetChanges() {
    setState(() {
      _firstNameController.text = initialFirstName;
      _lastNameController.text = initialLastName;
      _contactController.text = initialContact;
      _isDataChanged = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form reset successfully!')),
    );
  }

  // Navigate back to the home page
  void navigateToHomePage(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigateToHomePage(context); // Navigates to the home page
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0), // Consistent horizontal padding
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // First Name
              const SizedBox(height: 8),
              OutlinedTextInput(
                controller: _firstNameController,
                labelText: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Last Name
              const SizedBox(height: 8),
              OutlinedTextInput(
                controller: _lastNameController,
                labelText: 'Last Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email (read-only)
              const SizedBox(height: 8),
              OutlinedTextInput(
                controller: _emailController,
                labelText: 'Email',
                readOnly: true, // Set email as read-only
              ),
              const SizedBox(height: 24),

              // Contact
              const SizedBox(height: 8),
              OutlinedTextInput(
                controller: _contactController,
                labelText: 'Contact number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  if (!_isContactValid) {
                    return 'Contact number must start with 0 and be exactly 10 digits long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Button Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isDataChanged ? _saveChanges : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isDataChanged ? _resetChanges : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
