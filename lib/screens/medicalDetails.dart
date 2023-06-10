import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalDetails extends StatefulWidget {
  @override
  _MedicalDetailsState createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  final _formKey = GlobalKey<FormState>();

  String vaccinationStatus = "";
  late DateTime lastHealthCheckup;
  String selectedAllergy = "";
  String selectedDisease = "";
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
      ),
      body: Container(
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
              SizedBox(height: 8.0),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  labelText: "Enter your date of last checkup",
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      _dateController.text = formattedDate;
                      lastHealthCheckup = pickedDate;
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your date of last checkup';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedAllergy,
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
                    return 'Please select your allergies';
                  }
                  if (value == 'Other' && otherAllergy.isEmpty) {
                    return 'Please enter your other allergy';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
              // SizedBox(height: 16.0),
              // DropdownButtonFormField<String>(
              //   value: selectedDisease,
              //   onChanged: (newValue) {
              //     setState(() {
              //       selectedDisease = newValue!;
              //     });
              //   },
              //   items: diseases.map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     labelText: 'Diseases',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select your diseases';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 16.0),
              // DropdownButtonFormField<String>(
              //   value: vaccinationStatus,
              //   onChanged: (newValue) {
              //     setState(() {
              //       vaccinationStatus = newValue!;
              //     });
              //   },
              //   items: <String>[
              //     'Fully Vaccinated',
              //     'Partially Vaccinated',
              //     'Not Vaccinated'
              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     labelText: 'Vaccination Status',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Please select your vaccination status';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       // TODO: Perform diagnosis logic here
              //     }
              //   },
              //   child: Text('Diagnose'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
