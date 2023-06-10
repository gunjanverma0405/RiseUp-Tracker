import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController _aadharNumberController = TextEditingController();
  final TextEditingController _familyMembersController =
      TextEditingController();

  String educationStatus = "";
  int familyMembers = 0;
  String aadharNumber = "";
  String _bloodGroup = "";
  String chronicDisease = "";
  String lastMedicalCheckup = "";
  String educationStatusOfChildren = "";
  bool hasBankAccount = false;
  String panCardNumber = "";
  bool hasRationCard = false;
  String sessionOfInterest = "";
  String employmentStatus = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Education Status'),
                items: <String>[
                  'Didn\'t go to school',
                  'Less than secondary school'
                      'Secondary school',
                  'Senior secondary or equivalent',
                  'Bachelor\'s Degree',
                  'Master\'s Degree',
                  'Professional Degree',
                  'Doctorate Degree',
                  'Other'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your education status';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    educationStatus = value!;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _familyMembersController,
                decoration: InputDecoration(labelText: 'Family Members'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of family members';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _aadharNumberController,
                decoration: InputDecoration(labelText: 'Aadhar Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Aadhar number';
                  }
                  if (value.length != 12) {
                    return 'Aadhar number should be 12 digits';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Blood Group'),
                items: <String>[
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'AB+',
                  'AB-',
                  'O+',
                  'O-'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your blood group';
                  }
                  return null;
                },
                onChanged:                                                                                                                                   (value) {
                  setState(() {
                    _bloodGroup = value!;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Blood Group'),
              //   validator: (value) {
              //     if (value.isEmpty) {
              //       return 'Please enter your blood group';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     bloodGroup = value;
              //   },
              // ),
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(labelText: 'Chronic Disease'),
              //   items: <String>[
              //     'None',
              //     'Asthma',
              //     'Diabetes',
              //     'Heart Disease',
              //     'Other'
              //   ].map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Please select your chronic disease';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       chronicDisease = value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   decoration: InputDecoration(
              //       labelText: 'Last Medical Checkup / Doctor Visit'),
              //   validator: (value) {
              //     if (value.isEmpty) {
              //       return 'Please enter your last medical checkup/doctor visit date';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     lastMedicalCheckup = value;
              //   },
              // ),
              // TextFormField(
              //   decoration:
              //       InputDecoration(labelText: 'Education Status of Children'),
              //   validator: (value) {
              //     if (value.isEmpty) {
              //       return 'Please enter the education status of your children';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     educationStatusOfChildren = value;
              //   },
              // ),
              // SwitchListTile(
              //   title: Text('Bank Account'),
              //   value: hasBankAccount,
              //   onChanged: (value) {
              //     setState(() {
              //       hasBankAccount = value;
              //     });
              //   },
              // ),
              // if (hasBankAccount == true)
              //   TextFormField(
              //     decoration: InputDecoration(labelText: 'PAN Card Number'),
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return 'Please enter your PAN card number';
              //       }
              //       return null;
              //     },
              //     onSaved: (value) {
              //       panCardNumber = value;
              //     },
              //   ),
              // SwitchListTile(
              //   title: Text('Ration Card'),
              //   value: hasRationCard,
              //   onChanged: (value) {
              //     setState(() {
              //       hasRationCard = value;
              //     });
              //   },
              // ),
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(labelText: 'Sessions of Interest'),
              //   items: <String>['Fitness', 'Cooking', 'Art', 'Music', 'Other']
              //       .map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Please select your session of interest';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       sessionOfInterest = value;
              //     });
              //   },
              // ),
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(labelText: 'Employment Status'),
              //   items: <String>['Employed', 'Unemployed', 'Self-employed']
              //       .map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Please select your employment status';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       employmentStatus = value;
              //     });
              //   },
              // ),
              // SizedBox(height: 16.0),
              // RaisedButton(
              //   onPressed: () {
              //     if (_formKey.currentState.validate()) {
              //       _formKey.currentState.save();
              //       // Perform form submission here
              //     }
              //   },
              //   child: Text('Submit'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
