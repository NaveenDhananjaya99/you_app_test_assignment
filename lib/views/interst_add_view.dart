import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import '../models/profile_model.dart';
import '../viewmodels/profile_viewmodel.dart';

class InterestAddView extends StatefulWidget {
  Profile profile;
   InterestAddView({required this.profile}) ;

  @override
  _InterestAddViewState createState() => _InterestAddViewState();
}

class _InterestAddViewState extends State<InterestAddView> {
  final TextEditingController _interestController = TextEditingController();
  late List<String> _interests;

  @override
  void initState() {
    _interests = List.from(widget.profile.interests);
    super.initState();
  }
  void _addInterest(String interest) {
    if (interest.isNotEmpty && !_interests.contains(interest)) {
      setState(() {
        _interests.add(interest);
      });
    }
  }

  void _removeInterest(String interest) {
    setState(() {
      _interests.remove(interest);
    });
  }
  Future<void> updateProfile( BuildContext context) async {

    Profile profileUpdated = Profile(email: widget.profile.email, userName: widget.profile.userName, interests:_interests, birthday: widget.profile.birthday.toString(), height: double.parse(widget.profile.height.toString()), weight:  double.parse(widget.profile.weight.toString()), name: widget.profile.name , horoscope: widget.profile.horoscope,zodiac: widget.profile.zodiac);
    print(profileUpdated.height);
    print(profileUpdated.weight);
    print(profileUpdated.email);
    print(profileUpdated.userName);
    print(profileUpdated.birthday);
    print(profileUpdated.horoscope);
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.updateProfile(profileUpdated, context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(31, 66, 71, 1),
                Color.fromRGBO(13, 29, 35, 1),
                Color.fromRGBO(9, 20, 26, 1),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text('Back', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        updateProfile(context);
                      },
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Color.fromRGBO(171, 255, 253, 1),
                              Color.fromRGBO(69, 153, 219, 1),
                              Color.fromRGBO(170, 218, 255, 1),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Color.fromRGBO(148, 120, 62, 1),
                        Color.fromRGBO(243, 237, 166, 1),
                        Color.fromRGBO(248, 250, 229, 1),
                        Color.fromRGBO(255, 226, 190, 1),
                        Color.fromRGBO(213, 190, 136, 1),
                        Color.fromRGBO(248, 250, 229, 1),
                        Color.fromRGBO(213, 190, 136, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Tell everyone about yourself',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "What interest you?",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 327,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Color.fromRGBO(255, 255, 255, 0.06),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Wrap(
                      children: [
                        ..._interests.map((interest) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(217, 217, 217, 0.06),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(interest, style: TextStyle(color: Colors.white)),
                                SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () => _removeInterest(interest),
                                  child: Image.asset("assets/icons/close_icon.png"),
                                ),
                              ],
                            ),
                          ),
                        )),
                        Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: TextField(
                            controller: _interestController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8),

                            ),
                            style: TextStyle(color: Colors.white),
                            onSubmitted: (value) {
                              _addInterest(value);
                              _interestController.clear();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
