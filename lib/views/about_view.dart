import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_app_test/services/profile_api_services.dart';
import 'package:you_app_test/viewmodels/profile_viewmodel.dart';
import 'package:intl/intl.dart' as intl;
import 'package:you_app_test/views/login_view.dart';
import '../models/profile_model.dart';
import '../repositories/profile_repository.dart';
import '../utils/theme/widget_themes/text_theme.dart';
import 'package:file_picker/file_picker.dart';

import 'interst_add_view.dart';
class AboutView extends StatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _horoscopeController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _zodiacController = TextEditingController();
  File? _imageFile;
  bool _passwordVisible = false;

  bool _editAboutVisible = false;
  bool _aboutDataVisible = false;
  String? _selectedGender;
  DateTime? _selectedDate;
  Uint8List? imagevalue;
  late Profile  profile;
  late List<String> _interests;
  @override
   initState()  {
    _clearFields();
    _interests =[];
    profile = Profile(email: "", userName: "", interests: [], birthday: "", height: 0, weight: 0, name: "", horoscope: "",zodiac: "");

    checkUserProfile();
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
  Future<void> checkUserProfile() async {
    final profileViewModel =
       Provider.of<ProfileViewModel>(context, listen: false);
   await profileViewModel.getProfile();

    print("Profile Name 12121212: ${profileViewModel.profile?.name}");
    print("Profile Name 12121212: ${profileViewModel.profile?.interests}");
    profile= profileViewModel.profile!;

    if (profile != null &&
        profile?.name != "null" ||profile.name.isNotEmpty &&
       profile?.height != 0  &&
       profile?.weight != 0) {

      setState(() {
        _aboutDataVisible = true;
        _selectedDate = profileViewModel.profile!.birthday != null
            ? intl.DateFormat('MM/dd/yyyy').parse(profileViewModel.profile!.birthday!)
            : null;
        print(_selectedDate);
        _emailController.text =  profileViewModel.profile!.email;
         _horoscopeController.text =  profileViewModel.profile!.horoscope.toString();
        _heightController.text =  profileViewModel.profile!.height.toString();
         _weightController.text =  profileViewModel.profile!.weight.toString();
        _zodiacController.text = profileViewModel.profile!.zodiac;
        _interests=List.from(profileViewModel.profile!.interests);

      });
      print(_interests);
    } else {
      setState(() {
        _aboutDataVisible = false;
      });
    }

  }



  Future<void> uploadImage() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        withData: true,
        allowedExtensions: ['png', 'jpg', 'svg', 'jpeg'],
      );
    } catch (e) {
      print('Error picking file: $e');
      // Handle error as needed
      return;
    }
    print(result);
    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        imagevalue = file.bytes;
      });

    } else {
      // User canceled the picker
    }
  }

  Future<void> createProfile( BuildContext context) async {
    Profile profileUpdated = Profile(email: profile.email, userName: profile.userName, interests: ["kk"], birthday:intl.DateFormat('dd/MM/yyyy').format(_selectedDate!).toString(), height: double.parse(_heightController.text), weight:  double.parse(_weightController.text), name: _emailController.text , horoscope: _horoscopeController.text,zodiac: _zodiacController.text);
    print(profileUpdated.height);
    print(profileUpdated.weight);
    print(profileUpdated.email);
    print(profileUpdated.userName);
    print(profileUpdated.birthday);
    print(profileUpdated.horoscope);
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.createProfile(profileUpdated, context);
    checkUserProfile();
  }


  Future<void> updateProfile( BuildContext context) async {
    Profile profileUpdated = Profile(email: profile.email, userName: profile.userName, interests: [], birthday:intl.DateFormat('dd/MM/yyyy').format(_selectedDate!).toString(), height: double.parse(_heightController.text), weight:  double.parse(_weightController.text), name: _emailController.text , horoscope: _horoscopeController.text,zodiac: _zodiacController.text);
    print(profileUpdated.height);
    print(profileUpdated.weight);
    print(profileUpdated.email);
    print(profileUpdated.userName);
    print(profileUpdated.birthday);
    print(profileUpdated.horoscope);
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.updateProfile(profileUpdated, context);
    checkUserProfile();
  }

  void _clearFields() {
    _emailController.clear();
    _horoscopeController.clear();
    _heightController.clear();
    _weightController.clear();
    _selectedDate = null;

  }
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context,listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(9, 20, 26, 1),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Row(
                            children: [
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              Text('Back'),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            profileViewModel.profile?.userName??"",
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 359,
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromRGBO(22, 35, 41, 1),
                            image: imagevalue != null
                                ? DecorationImage(
                              image: MemoryImage(imagevalue!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child:imagevalue != null? Stack(
                            children: [
                              if (imagevalue == null)
                                Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              profile.horoscope != "null" ? Positioned(
                                bottom: 10,
                                left: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(
                                        35, 35, 35, 0.66),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/icons/Horoscope.png',
                                          color: Colors.white,
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: 4),
                                        Text(profile.horoscope, style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600)),


                                      ],
                                    ),
                                  ),
                                ),
                              ):Container(),

                              profile.horoscope != "null" ? Positioned(
                                bottom: 10,
                                left: 120,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(
                                        35, 35, 35, 0.66),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/icons/Horoscope.png',
                                          color: Colors.white,
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: 4),
                                        Text(profile.zodiac, style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600)),


                                      ],
                                    ),
                                  ),
                                ),
                              ):Container(),


                              Positioned(
                                bottom: 80,
                                left: 10,
                                child: Text(
                                  profile.userName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 60,
                                left: 10,
                                child: Text(
                                  'Male',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),


                            ],
                          ):Stack(
                            children: [
                              Positioned(
                                bottom: 30,
                                left: 20,
                                child: Text(
                                  profile.userName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _editAboutVisible
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: 359,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color.fromRGBO(14, 25, 31, 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Text(
                                      'About',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  GestureDetector(
                                    onTap: () {
                                      _aboutDataVisible?updateProfile(context):createProfile(context);
                                      // setState(() {
                                      //   _editAboutVisible = false;
                                      // });
                                    },
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
                                        'Save & Update',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 31),
                                  Row(
                                    children: [
                                      Container(
                                        width: 57,
                                        height: 57,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color:
                                              Color.fromRGBO(22, 35, 41, 1),
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              uploadImage();
                                            },
                                            child: ShaderMask(
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  colors: [
                                                    Color.fromRGBO(
                                                        148, 120, 62, 1),
                                                    Color.fromRGBO(
                                                        243, 237, 166, 1),
                                                    Color.fromRGBO(
                                                        248, 250, 229, 1),
                                                    Color.fromRGBO(
                                                        255, 226, 190, 1),
                                                    Color.fromRGBO(
                                                        213, 190, 136, 1),
                                                    Color.fromRGBO(
                                                        248, 250, 229, 1),
                                                    Color.fromRGBO(
                                                        213, 190, 136, 1),
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ).createShader(bounds);
                                              },
                                              child: Text(
                                                '+',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 36),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text("Add image")

                                    ],
                                  ),
                                  SizedBox(height: 29),
                                  //Display name
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Display name:", style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 220,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.06),
                                        ),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(11),
                                            hintText: 'Enter Name',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 13,

                                            ),

                                            hintTextDirection: TextDirection.rtl,

                                          ),

                                          textAlign: TextAlign.right,
                                          style: TextStyle(color:  Colors.white.withOpacity(0.5),),// Sets the text color of the input text to white
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),

// Gender
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gender:",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.33),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              width: 220,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: Color.fromRGBO(255, 255, 255, 0.06),
                              ),
                              child: DropdownButtonFormField<String>(

                                alignment: AlignmentDirectional.centerEnd,
                                dropdownColor:Color.fromRGBO(22, 35, 41, 1),
                                decoration: InputDecoration(
                                  border: InputBorder.none,

                                  contentPadding: EdgeInsets.all(11),
                                  hintText: 'Select Gender',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 13,
                                  ),

                                 hintTextDirection: TextDirection.rtl,

                                ),
                                value: _selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedGender = value; // Update selected gender
                                  });
                                },
                                items: <String>['Male', 'Female', 'Other'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SizedBox(
                                      width:170.0,
                                      child: Text(value,style:TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 13,


                                      ),
                                      textAlign: TextAlign.right,),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                                  SizedBox(height: 12),

                                  // Birthday
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Birthday:",
                                        style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                          Container(
                            width: 220,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: Color.fromRGBO(255, 255, 255, 0.06),
                            ),
                            child: TextFormField(
                              readOnly: true, // Prevents manual editing of the date
                              onTap: () async {
                                // Show date picker when the TextFormField is tapped
                                final DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate ?? DateTime.now().subtract(Duration(days: 1)),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),

                                );

                                // Handle selected date
                                if (pickedDate != null) {
                                  // You can format the pickedDate as needed
                                  // For example, display in a specific format or store it in a variable
                                  // String formattedDate = DateFormat.yMMMd().format(pickedDate);
                                  // // Example: setState(() => _selectedDate = formattedDate);
                                  print('Selected date: $pickedDate');
                                  setState(() {
                                    _selectedDate = pickedDate;
                                  });
                                }
                              },
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.right,
                              controller: _selectedDate == null
                                  ? null
                                  : TextEditingController(
                                text: intl.DateFormat.yMMMd().format(_selectedDate!),
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(11),

                                hintText:'DD MM YYYY',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 13,

                                ),

                                 hintTextDirection: TextDirection.rtl,

                              ),
                            ),
                          ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  //Horoscope
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Horoscope:", style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 220,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(9),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.06),
                                        ),
                                        child: TextField(
                                          readOnly: true,
                                          controller: _horoscopeController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(11),
                                            hintText: '---',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 13,

                                            ),

                                             hintTextDirection: TextDirection.rtl,

                                          ),

                                          textAlign: TextAlign.right,
                                          style: TextStyle(color:  Colors.white.withOpacity(0.5),), // Sets the text color of the input text to white
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  //zodiac
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Zodiac:", style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 220,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(9),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.06),
                                        ),
                                        child: TextField(
                                          readOnly: true,
                                          controller: _zodiacController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(11),
                                            hintText: '---',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 13,

                                            ),

                                            hintTextDirection: TextDirection.rtl,

                                          ),

                                          textAlign: TextAlign.right,
                                          style: TextStyle(color:  Colors.white.withOpacity(0.5),), // Sets the text color of the input text to white
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  //height
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Height (cm):", style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 220,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(9),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.06),
                                        ),
                                        child: TextField(
                                          controller: _heightController,
                                          keyboardType: TextInputType.numberWithOptions(decimal: true), // Allows decimal input
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Limits to 2 decimal places
                                          ],
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(11),
                                            hintText: 'Add height ',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 13,

                                            ),

                                            hintTextDirection: TextDirection.rtl,

                                          ),

                                          textAlign: TextAlign.right,
                                          style: TextStyle(color:  Colors.white.withOpacity(0.5),),// Sets the text color of the input text to white
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  //weight
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Weight (Kg):", style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 220,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(9),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.06),
                                        ),
                                        child: TextField(
                                          controller: _weightController,
                                          keyboardType: TextInputType.numberWithOptions(decimal: true), // Allows decimal input
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')), // Limits to 2 decimal places
                                          ],
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(11),
                                            hintText: 'Add weight',
                                            hintStyle: TextStyle(
                                              color: Colors.white.withOpacity(0.5),
                                              fontSize: 13,

                                            ),

                                            hintTextDirection: TextDirection.rtl,

                                          ),
textAlign: TextAlign.right,
                                          style: TextStyle(color:  Colors.white.withOpacity(0.5),), // Sets the text color of the input text to white
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ],
                          ),
                        ))
                    : _aboutDataVisible ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: 359,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color.fromRGBO(14, 25, 31, 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Text(
                                      'About',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/icons/img.png', // Replace with your image path
                                      color: Colors.white,
                                      width: 24, // Adjust width as needed
                                      height: 24, // Adjust height as needed
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _editAboutVisible = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Birthday',
                                       style: TextStyle(color:Color.fromRGBO(
                                    255, 255, 255, 0.33),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      profileViewModel.profile!.birthday??"",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Horoscope',
                                      style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      profileViewModel.profile!.horoscope.toString()??"",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Zodiac',
                                      style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      profileViewModel.profile?.zodiac != null?  profileViewModel.profile!.zodiac: "---",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Height',
                                      style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      profileViewModel.profile!.height.toString()??"",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Weight',
                                      style: TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 0.33),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      profileViewModel.profile!.weight.toString()??"",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )):Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 359,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color.fromRGBO(14, 25, 31, 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16),
                                child: Text(
                                  'About',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Image.asset(
                                  'assets/icons/img.png', // Replace with your image path
                                  color: Colors.white,
                                  width: 24, // Adjust width as needed
                                  height: 24, // Adjust height as needed
                                ),
                                onPressed: () {
                                  setState(() {
                                    _editAboutVisible = true;
                                  });
                                },
                              ),
                            ],
                          ),

                           Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Add in your your to help others know you better',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 359,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color.fromRGBO(14, 25, 31, 1),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Text(
                                    'Interest',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/img.png', // Replace with your image path
                                    color: Colors.white,
                                    width: 24, // Adjust width as needed
                                    height: 24, // Adjust height as needed
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => InterestAddView(profile: profile,)),
                                    );
                                  },
                                ),
                              ],
                            ),
                            _interests.length>0? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: _interests.map((interest) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(217, 217, 217, 0.06),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
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
                                  ),
                                )).toList(),
                              ),
                            )
                            :Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Add in your interest to find a better match',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    )),

                // IconButton(
                //   icon: Image.asset(
                //     'assets/icons/img.png', // Replace with your image path
                //     color: Colors.white,
                //     width: 24, // Adjust width as needed
                //     height: 24, // Adjust height as needed
                //   ),
                //   onPressed: () async {
                //     final SharedPreferences _prefs = await SharedPreferences.getInstance();
                //     _prefs.clear();
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => LoginView()),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
