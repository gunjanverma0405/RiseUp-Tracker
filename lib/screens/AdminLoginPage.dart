import 'package:flutter/material.dart';
import 'package:riseuptracker/screens/socialAwareness/socialAwarenessDashboard.dart';
import 'package:riseuptracker/widgets/custom_textfield.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 50, top: 40),
                  child: Image.asset(
                    'assets/images/Logo2.png',
                    width: 250,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: const Text(
                    "Admin Login",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 32.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Enter userID'),
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty || value != "admin") {
                              return 'Please enter a valid userID';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(labelText: 'Enter password'),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty || value != "12345") {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Material(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Perform login logic here
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => socialAwarenessDashboard()),
                              );
                              // Navigate to the admin dashboard or perform required actions
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            width: 250,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
