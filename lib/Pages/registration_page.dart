import 'package:flutter/material.dart';
import './auth.dart';
import 'login_page.dart';

class RegScreen extends StatelessWidget {
  //Use this check if it's login or register
  final bool _isLogin = false;

  //Use this form key to validate user's input
  final _formKey = GlobalKey<FormState>();

  //Use this to store user inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegScreen({super.key});

  handleSubmit() async {
    //Validate user inputs using form key
    if (_formKey.currentState!.validate()) {
      //Get inputs from the controllers
      final email = _emailController.value.text;
      final password = _passwordController.value.text;
      //Check if is login or register
      if(_isLogin) {
        await Auth().signInWithEmailAndPassword(email, password);
      } else {
        await Auth().registerWithEmailAndPassword(email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Automatic Baby Cradle'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/babysleeping.jpg', // Provide the path to your image asset
                  height: 100, // Adjust height as needed
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    child: Text(_isLogin ? 'Login' :'Register'),
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToNextScreen(context);
                    },
                    child: Text(_isLogin ? 'Register instead?' :'Login instead?'),
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
void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthScreen()));
}