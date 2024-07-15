class Profile {
  final String email;
  final String userName;
  final List<String> interests;
  final String birthday;
  final double height;
  final double weight;
  final String name;
  final String horoscope;
  final String zodiac;

  Profile({required this.email, required this.userName, required this.interests,required this.birthday,required this.height, required this.weight,required this.name,required this.horoscope,required this.zodiac});

  // factory Profile.fromJson(Map<String, dynamic> json) {
  //   return Profile(
  //     email: json['email'],
  //     userName: json['username'],
  //     interests: List<String>.from(json['interests']),
  //   );
  // }
}