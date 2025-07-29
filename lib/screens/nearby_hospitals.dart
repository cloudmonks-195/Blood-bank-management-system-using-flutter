import 'package:flutter/material.dart';
import 'dart:math';

class NearbyHospitalsPage extends StatefulWidget {
  const NearbyHospitalsPage({super.key});

  @override
  _NearbyHospitalsPageState createState() => _NearbyHospitalsPageState();
}

class _NearbyHospitalsPageState extends State<NearbyHospitalsPage> {
  final List<Map<String, String>> hospitals = [
    // **Uttar Pradesh**
    {'name': 'PGI Lucknow', 'address': 'Lucknow, UP', 'phone': '0522-2668000'},
    {'name': 'KGMU', 'address': 'Lucknow, UP', 'phone': '0522-2258001'},
    {
      'name': 'Fortis Hospital',
      'address': 'Noida, UP',
      'phone': '0120-4177777'
    },
    {
      'name': 'Max Super Specialty',
      'address': 'Vaishali, Ghaziabad, UP',
      'phone': '0120-4609777'
    },
    {
      'name': 'Yashoda Hospital',
      'address': 'Kaushambi, Ghaziabad, UP',
      'phone': '0120-4305050'
    },

    // **New Delhi**
    {
      'name': 'AIIMS Delhi',
      'address': 'Ansari Nagar, New Delhi',
      'phone': '011-26588500'
    },
    {
      'name': 'Apollo Hospital',
      'address': 'Saket, New Delhi',
      'phone': '011-48545733'
    },
    {
      'name': 'Fortis Escorts Heart Institute',
      'address': 'Okhla Road, New Delhi',
      'phone': '011-26925000'
    },
    {
      'name': 'Sir Ganga Ram Hospital',
      'address': 'Rajinder Nagar, New Delhi',
      'phone': '011-25720000'
    },
    {
      'name': 'Max Super Speciality Hospital',
      'address': 'Saket, New Delhi',
      'phone': '011-26565050'
    },

    // **Maharashtra**
    {
      'name': 'Kokilaben Dhirubhai Ambani Hospital',
      'address': 'Andheri West, Mumbai',
      'phone': '022-42696969'
    },
    {
      'name': 'Breach Candy Hospital',
      'address': 'Breach Candy, Mumbai',
      'phone': '022-23663030'
    },
    {
      'name': 'Lilavati Hospital',
      'address': 'Bandra, Mumbai',
      'phone': '022-26755000'
    },
    {
      'name': 'Tata Memorial Hospital',
      'address': 'Parel, Mumbai',
      'phone': '022-24177000'
    },
    {
      'name': 'Jaslok Hospital',
      'address': 'Peddar Road, Mumbai',
      'phone': '022-66573030'
    },

    // **Tamil Nadu**
    {
      'name': 'Fortis Malar Hospital',
      'address': 'Adyar, Chennai',
      'phone': '044-24917777'
    },
    {
      'name': 'Apollo Hospital',
      'address': 'Greams Road, Chennai',
      'phone': '044-28290808'
    },
    {
      'name': 'MIOT International',
      'address': 'Manapakkam, Chennai',
      'phone': '044-42774444'
    },
    {
      'name': 'Sri Ramachandra Medical Centre',
      'address': 'Porur, Chennai',
      'phone': '044-24768000'
    },
    {
      'name': 'Global Hospitals',
      'address': 'Perumbakkam, Chennai',
      'phone': '044-69000000'
    },

    // **Karnataka**
    {
      'name': 'Manipal Hospital',
      'address': 'Old Airport Road, Bangalore',
      'phone': '080-25025353'
    },
    {
      'name': 'Narayana Health',
      'address': 'Whitefield, Bangalore',
      'phone': '080-67890000'
    },
    {
      'name': 'Fortis La Femme Hospital',
      'address': 'Richmond Road, Bangalore',
      'phone': '080-66112222'
    },
    {
      'name': 'Sakra Premium Clinic',
      'address': 'Bangalore',
      'phone': '080-40001000'
    },
    {
      'name': 'BGS Gleneagles Global Hospital',
      'address': 'Kengeri, Bangalore',
      'phone': '080-28027115'
    },

    // **Kerala**
    {
      'name': 'Aster Medcity',
      'address': 'Kochi, Kerala',
      'phone': '0484-6692000'
    },
    {
      'name': 'Kochi Medical College',
      'address': 'Kochi, Kerala',
      'phone': '0484-2858301'
    },
    {
      'name': 'PVS Memorial Hospital',
      'address': 'Kochi, Kerala',
      'phone': '0484-2805500'
    },
    {
      'name': 'Sree Chitra Tirunal Institute for Medical Sciences',
      'address': 'Trivandrum, Kerala',
      'phone': '0471-2446622'
    },
    {
      'name': 'Aster DM Healthcare',
      'address': 'Calicut, Kerala',
      'phone': '0495-6456000'
    },

    // **West Bengal**
    {
      'name': 'Apollo Gleneagles Hospitals',
      'address': 'Salt Lake, Kolkata',
      'phone': '033-66022300'
    },
    {
      'name': 'Belle Vue Clinic',
      'address': 'Mandeville Gardens, Kolkata',
      'phone': '033-22236132'
    },
    {
      'name': 'S.S.K.M. Hospital',
      'address': 'Kolkata',
      'phone': '033-22183000'
    },
    {
      'name': 'Calcutta National Medical College & Hospital',
      'address': 'Kolkata',
      'phone': '033-25503040'
    },
    {
      'name': 'The Medical Research Institute',
      'address': 'Kolkata',
      'phone': '033-24627101'
    },

    // **Rajasthan**
    {
      'name': 'Fortis Escorts Hospital',
      'address': 'Jaipur, Rajasthan',
      'phone': '0141-4106262'
    },
    {
      'name': 'SMS Medical College',
      'address': 'Jaipur, Rajasthan',
      'phone': '0141-2721232'
    },
    {
      'name': 'Mahavir Hospital',
      'address': 'Jaipur, Rajasthan',
      'phone': '0141-2648301'
    },
    {
      'name': 'Narayana Multispeciality Hospital',
      'address': 'Jaipur, Rajasthan',
      'phone': '0141-4000000'
    },
    {
      'name': 'Vidyashree Multi-Speciality Hospital',
      'address': 'Udaipur, Rajasthan',
      'phone': '0294-2437383'
    },

    // **Andhra Pradesh**
    {
      'name': 'Care Hospital',
      'address': 'Hyderabad, AP',
      'phone': '040-23351333'
    },
    {
      'name': 'Narayana Hrudayalaya',
      'address': 'Hyderabad, AP',
      'phone': '040-30597700'
    },
    {
      'name': 'Kamineni Hospitals',
      'address': 'Hyderabad, AP',
      'phone': '040-27260000'
    },
    {
      'name': 'Yashoda Hospital',
      'address': 'Hyderabad, AP',
      'phone': '040-49588888'
    },
    {
      'name': 'Global Hospitals',
      'address': 'Hyderabad, AP',
      'phone': '040-44730000'
    },

    // **Gujarat**
    {
      'name': 'Sterling Hospital',
      'address': 'Ahmedabad, Gujarat',
      'phone': '079-40203030'
    },
    {
      'name': 'Kokilaben Dhirubhai Ambani Hospital',
      'address': 'Ahmedabad, Gujarat',
      'phone': '079-66001234'
    },
    {
      'name': 'Medilink Hospital',
      'address': 'Ahmedabad, Gujarat',
      'phone': '079-27661777'
    },
    {
      'name': 'Sola Civil Hospital',
      'address': 'Ahmedabad, Gujarat',
      'phone': '079-27661660'
    },
    {
      'name': 'Vivekanand Hospital',
      'address': 'Surat, Gujarat',
      'phone': '0261-2698777'
    },

    // **Madhya Pradesh**
    {
      'name': 'Indore Super Speciality Hospital',
      'address': 'Indore, MP',
      'phone': '0731-4277555'
    },
    {
      'name': 'Shri Harish Hospital',
      'address': 'Bhopal, MP',
      'phone': '0755-2664567'
    },
    {
      'name': 'Narmada Trauma and Medical Centre',
      'address': 'Jabalpur, MP',
      'phone': '0761-2601818'
    },
    {
      'name': 'Fortis Hospital',
      'address': 'Bhopal, MP',
      'phone': '0755-2464577'
    },
    {'name': 'AIIMS Bhopal', 'address': 'Bhopal, MP', 'phone': '0755-2675100'},

    // **Haryana**
    {
      'name': 'Fortis Memorial Research Institute',
      'address': 'Gurgaon, Haryana',
      'phone': '0124-4370000'
    },
    {
      'name': 'Medanta - The Medicity',
      'address': 'Gurgaon, Haryana',
      'phone': '0124-4141414'
    },
    {
      'name': 'Artemis Hospital',
      'address': 'Gurgaon, Haryana',
      'phone': '0124-4511000'
    },
    {
      'name': 'Shree Krishna Hospital',
      'address': 'Faridabad, Haryana',
      'phone': '0129-4195555'
    },
    {
      'name': 'Max Super Speciality Hospital',
      'address': 'Gurgaon, Haryana',
      'phone': '0124-4370000'
    },

    // **Bihar**
    {
      'name': 'Indira Gandhi Institute of Medical Sciences (IGIMS)',
      'address': 'Patna, Bihar',
      'phone': '0612-2282000'
    },
    {
      'name': 'Patna Medical College and Hospital',
      'address': 'Patna, Bihar',
      'phone': '0612-2288282'
    },
    {
      'name': 'Paras HMRI Hospital',
      'address': 'Patna, Bihar',
      'phone': '0612-3008888'
    },
    {
      'name': 'Shree Harsha Hospital',
      'address': 'Patna, Bihar',
      'phone': '0612-2273830'
    },
    {
      'name': 'Bhagalpur Medical College and Hospital',
      'address': 'Bhagalpur, Bihar',
      'phone': '0641-2453276'
    },

    // **Punjab**
    {
      'name': 'Fortis Hospital',
      'address': 'Mohali, Punjab',
      'phone': '0172-5091100'
    },
    {
      'name': 'Max Super Speciality Hospital',
      'address': 'Mohali, Punjab',
      'phone': '0172-2263500'
    },
    {
      'name': 'Dayanand Medical College and Hospital (DMCH)',
      'address': 'Ludhiana, Punjab',
      'phone': '0161-2600700'
    },
    {
      'name': 'Guru Nanak Dev Hospital',
      'address': 'Amritsar, Punjab',
      'phone': '0183-2432200'
    },
    {
      'name': 'Civil Hospital',
      'address': 'Amritsar, Punjab',
      'phone': '0183-2250474'
    },

    // **Assam**
    {
      'name': 'Gauhati Medical College',
      'address': 'Guwahati, Assam',
      'phone': '0361-2132211'
    },
    {
      'name': 'Nemcare Hospital',
      'address': 'Guwahati, Assam',
      'phone': '0361-2462666'
    },
    {
      'name': 'Lakhimi Hospital',
      'address': 'Jorhat, Assam',
      'phone': '0376-2307172'
    },
    {
      'name': 'Sankardev Hospital',
      'address': 'Dibrugarh, Assam',
      'phone': '0373-2321555'
    },
    {
      'name': 'Kokrajhar Medical College',
      'address': 'Kokrajhar, Assam',
      'phone': '03661-270601'
    },

    // **Odisha**
    {
      'name': 'SUM Hospital',
      'address': 'Bhubaneswar, Odisha',
      'phone': '0674-2350085'
    },
    {
      'name': 'AIIMS Bhubaneswar',
      'address': 'Bhubaneswar, Odisha',
      'phone': '0674-2476789'
    },
    {
      'name': 'Kalinga Institute of Medical Sciences',
      'address': 'Bhubaneswar, Odisha',
      'phone': '0674-2300181'
    },
    {
      'name': 'Care Hospital',
      'address': 'Bhubaneswar, Odisha',
      'phone': '0674-2350471'
    },
    {
      'name': 'Hi-Tech Medical College',
      'address': 'Bhubaneswar, Odisha',
      'phone': '0674-2742155'
    },
  ];

  List<Map<String, String>> _filteredHospitals = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredHospitals = hospitals; // Initially show all hospitals
  }

  void _filterHospitals(String query) {
    setState(() {
      _searchQuery = query;
      _filteredHospitals = hospitals
          .where((hospital) =>
              hospital['address']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showHospitalDetails(Map<String, String> hospital) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(hospital['name']!),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address: ${hospital['address']}'),
              const SizedBox(height: 8),
              Text('Phone: ${hospital['phone']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
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
        title: const Text('Nearby Hospitals'),
        backgroundColor: Colors.redAccent,
        elevation: 4,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _filterHospitals,
                decoration: const InputDecoration(
                  hintText: 'Search by address...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.pinkAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _filteredHospitals.length,
          itemBuilder: (context, index) {
            final hospital = _filteredHospitals[index];
            return GestureDetector(
              onTap: () => _showHospitalDetails(hospital),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.redAccent.withOpacity(0.2)],
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.redAccent,
                      child: const Icon(
                        Icons.local_hospital,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      hospital['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hospital['address']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Phone: ${hospital['phone']!}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.phone,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
