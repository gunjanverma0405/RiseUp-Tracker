import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riseuptracker/screens/attendeeDashboard.dart';

class MedicalDetails extends StatefulWidget {
  @override
  _MedicalDetailsState createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  final _formKey = GlobalKey<FormState>();

  String vaccinationStatus = "";
  late DateTime lastHealthCheckup;
  String selectedDisease = "";
  String chronicDisease = "";
  String otherchronicDisease = "";
  String selectedAllergy = "";
  String otherAllergy = "";

  final TextEditingController _dateController = TextEditingController();

  List<String> diseases = [
    'None',
    'Hypertension',
    'Diabetes',
    'Asthma',
    'Heart disease',
    'Cancer',
    'Autoimmune disorder',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Diagnosis'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/medical.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                // TextFormField(
                //   controller: _dateController,
                //   decoration: const InputDecoration(
                //     icon: Icon(Icons.calendar_today),
                //     labelText: "Enter your date of last checkup",
                //   ),
                //   readOnly: true,
                //   onTap: () async {
                //     DateTime? pickedDate = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime(1900),
                //       lastDate: DateTime.now(),
                //     );

                //     if (pickedDate != null) {
                //       String formattedDate =
                //           DateFormat('dd-MM-yyyy').format(pickedDate);
                //       setState(() {
                //         _dateController.text = formattedDate;
                //         lastHealthCheckup = pickedDate;
                //       });
                //     }
                //   },
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your date of last checkup';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter symptoms (if any)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your symptoms';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Chronic Disease',
                    border: OutlineInputBorder(),
                  ),
                  items: <String>[
                    'None',
                    'Asthma',
                    'Diabetes',
                    'Heart Disease',
                    'Other'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your chronic disease';
                    }
                    if (value == 'Other' && otherAllergy.isEmpty) {
                      return 'Please enter your chronic disease';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      chronicDisease = value!;
                    });
                  },
                ),
                SizedBox(height: 8.0),
                if (chronicDisease == 'Other')
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Your Chronic Disease',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        otherchronicDisease = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your chronic disease';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  onChanged: (newValue) {
                    setState(() {
                      selectedAllergy = newValue!;
                    });
                  },
                  items: [
                    'None',
                    'Pollen',
                    'Dust',
                    'Pet dander',
                    'Food',
                    'Medication',
                    'Insect sting',
                    'Latex',
                    'Other',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Allergies',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your allergy';
                    }
                    if (value == 'Other' && otherAllergy.isEmpty) {
                      return 'Please enter your other allergy';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                if (selectedAllergy == 'Other')
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Other Allergy',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        otherAllergy = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your other allergy';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SessionPage()));
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
