class Donor {
  String name;
  String bloodGroup;
  String age;
  String gender;
  String contactInfo;

  Donor({
    required this.name,
    required this.bloodGroup,
    required this.age,
    required this.gender,
    required this.contactInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bloodGroup': bloodGroup,
      'age': age,
      'gender': gender,
      'contactInfo': contactInfo,
    };
  }

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      name: map['name'],
      bloodGroup: map['bloodGroup'],
      age: map['age'],
      gender: map['gender'],
      contactInfo: map['contactInfo'],
    );
  }
}
