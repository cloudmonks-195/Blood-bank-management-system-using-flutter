import 'package:blood_bank/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  String _userEmail = '';
  String _userName = '';
  String _bloodGroup = '';
  String _contact = '';
  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  void initState() {
    super.initState();
    _userEmail = _auth.currentUser?.email ?? 'No Email';
    _fetchUserProfile();
  }

  // Fetch user profile data
  Future<void> _fetchUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['name'] ?? 'No Name Set';
          _bloodGroup = userDoc['bloodGroup'] ?? 'Not Set';
          _contact = userDoc['contact'] ?? 'Not Available';
        });
      }
    }
  }

  // Save or update profile
  Future<void> _saveProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': _nameController.text.isEmpty ? _userName : _nameController.text,
        'email': user.email,
        'bloodGroup': _bloodGroup.isEmpty ? 'Not Set' : _bloodGroup,
        'contact': _contactController.text.isEmpty
            ? _contact
            : _contactController.text,
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated Successfully')),
      );
      _fetchUserProfile(); // Refresh profile data
    }
  }

  // Save donor details
  Future<void> _saveDonorDetails(String name, String age, String gender,
      String bloodGroup, String contact) async {
    await _firestore.collection('donors').add({
      'name': name,
      'age': age,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'contact': contact,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Donor Details Added Successfully')),
    );
  }

  // Show dialog for editing profile
  void _editProfileDialog() {
    _nameController.text = _userName;
    _contactController.text = _contact;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration:
                      const InputDecoration(labelText: 'Enter your Full Name'),
                ),
                DropdownButtonFormField<String>(
                  value: _bloodGroup.isEmpty ? null : _bloodGroup,
                  decoration: const InputDecoration(labelText: 'Blood Group'),
                  items: _bloodGroups
                      .map((group) => DropdownMenuItem(
                            value: group,
                            child: Text(group),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _bloodGroup = value!;
                    });
                  },
                ),
                TextField(
                  controller: _contactController,
                  decoration: const InputDecoration(labelText: 'Contact'),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveProfile();
                Navigator.of(context).pop();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for adding donor details
  void _addDonorDetailsDialog() {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String age = '';
    String gender = '';
    String bloodGroup = '';
    String contact = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Donor Details'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Enter your full Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Name is required' : null,
                    onSaved: (value) => name = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Age is required' : null,
                    onSaved: (value) => age = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Gender'),
                    validator: (value) =>
                        value!.isEmpty ? 'Gender is required' : null,
                    onSaved: (value) => gender = value!,
                  ),
                  DropdownButtonFormField<String>(
                    value: bloodGroup.isEmpty ? null : bloodGroup,
                    decoration: const InputDecoration(labelText: 'Blood Group'),
                    items: _bloodGroups
                        .map((group) => DropdownMenuItem(
                              value: group,
                              child: Text(group),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        bloodGroup = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Contact'),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.isEmpty ? 'Contact is required' : null,
                    onSaved: (value) => contact = value!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  _saveDonorDetails(name, age, gender, bloodGroup, contact);
                  Navigator.of(context).pop();
                }
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.pinkAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _userName.isNotEmpty ? _userName : 'Your Name',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: $_userEmail',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Blood Group: $_bloodGroup',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contact: $_contact',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _editProfileDialog,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addDonorDetailsDialog,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    child: const Text(
                      'Add Donor Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                          (Route route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
