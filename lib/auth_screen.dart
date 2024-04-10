import 'dart:io';

import 'package:chat_app/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';
  File? selectedImage;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_isLogin && selectedImage == null) {
      return;
    }
    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: enteredEmail, password: enteredPassword);
      } else {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${credential.user!.uid}.jpg');
        await storageRef.putFile(selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed')));
    }
    if(context.mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
                width: 200,
                child: Image.asset('assets/img.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                selectedImage = pickedImage;
                              },
                            ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              enteredEmail = newValue!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Enter password with atleast 6 characters';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              enteredPassword = newValue!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                              onPressed: _isLoading ? () {} : _submit,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: SizedBox(width: 100, child:Center(child: _isLoading ? const CircularProgressIndicator() : Text(_isLogin ? 'Login' : 'Sign up')))),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'Already have an account? Login'))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
