import 'package:blood_bank/screens/nearby_hospitals.dart';
import 'package:blood_bank/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _searchQuery = ''; // To store search input

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _showRequestBloodDialog());
  }

  void _showRequestBloodDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Request for Blood'),
          content: const Text('Do you need blood donation information?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _showAddDonorForm(); // Show the form if the user selects "No"
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Add any action if user selects "Yes"
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddDonorForm() {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String age = '';
    String gender = '';
    String bloodGroup = '';
    String contact = '';

    // List of blood groups
    final List<String> bloodGroups = [
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Add Donor Information'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name field
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Enter Your Full Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Name is required' : null,
                    onSaved: (value) => name = value!,
                  ),
                  // Age field
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Age is required' : null,
                    onSaved: (value) => age = value!,
                  ),
                  // Gender field
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Gender'),
                    validator: (value) =>
                        value!.isEmpty ? 'Gender is required' : null,
                    onSaved: (value) => gender = value!,
                  ),
                  // Dropdown for Blood Group
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Blood Group'),
                    value: bloodGroup.isEmpty
                        ? null
                        : bloodGroup, // Show selected value
                    onChanged: (newValue) {
                      setState(() {
                        bloodGroup = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Blood Group is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      bloodGroup = value!;
                    },
                    items: bloodGroups.map((group) {
                      return DropdownMenuItem<String>(
                        value: group,
                        child: Text(group),
                      );
                    }).toList(),
                  ),
                  // Contact field
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Mobile number'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Mobile number is required' : null,
                    onSaved: (value) => contact = value!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the form
              },
              child: const Text('Cancel'),
            ),
            // Submit button
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  _addDonorToFirestore(name, age, gender, bloodGroup, contact);
                  Navigator.of(context).pop(); // Close the form
                }
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addDonorToFirestore(String name, String age, String gender,
      String bloodGroup, String contact) async {
    try {
      await FirebaseFirestore.instance.collection('donors').add({
        'name': name,
        'age': int.parse(age),
        'gender': gender,
        'bloodGroup': bloodGroup,
        'contact': contact
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donor information added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding donor: $e')),
      );
    }
  }

  // Fetch donors based on the blood group search query
  Stream<QuerySnapshot> _fetchDonors() {
    if (_searchQuery.isEmpty) {
      return FirebaseFirestore.instance.collection('donors').snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('donors')
          .where('bloodGroup', isEqualTo: _searchQuery)
          .snapshots();
    }
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _donorList();
      case 1:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NearbyHospitalsPage(),
            ),
          );
        });
        return _donorList();
      case 2:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        });
        return _donorList();
      default:
        return _donorList();
    }
  }

  Widget _donorList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Available Donors',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // Search bar for filtering by blood group
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value; // Update search query
              });
            },
            decoration: InputDecoration(
              labelText: 'Search by Blood Group',
              hintText: 'Enter blood group (e.g., A+, O-)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        // Expanded widget for StreamBuilder
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _fetchDonors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No donors available',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                }

                final donors = snapshot.data!.docs;

                return Column(
                  children: [
                    Text(
                      'Total Active Donors: ${donors.length}',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: donors.length,
                        itemBuilder: (context, index) {
                          final donor = donors[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 4,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.redAccent,
                                child: Text(
                                  donor['name'][0],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              title: Text(
                                donor['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Age: ${donor['age']}, Gender: ${donor['gender']}, Group: ${donor['bloodGroup']}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Contact: ${donor['contact']}',
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.blue),
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.bloodtype,
                                color: Colors.red,
                              ),
                              onTap: () {
                                var donorData =
                                    donor.data() as Map<String, dynamic>;
                                _showDonorDetailsDialog(donorData);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showDonorDetailsDialog(Map<String, dynamic> donor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Donor Details - ${donor['name']}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Age: ${donor['age']}'),
              Text('Gender: ${donor['gender']}'),
              Text('Blood Group: ${donor['bloodGroup']}'),
              Text('Contact: ${donor['contact']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
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
        title: const Text(
          'Blood Bank App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.redAccent, Colors.pinkAccent, Colors.white],
          ),
        ),
        child: _getCurrentPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Donors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert),
            label: 'Near By Hospitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
