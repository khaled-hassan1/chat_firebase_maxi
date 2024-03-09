import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../picker/user_image.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String userName,
    File image,
    String password,
    bool isLogin,
    BuildContext context,
  ) submitAuth;

  const AuthForm(
      {super.key, required this.isLoading, required this.submitAuth});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImageFile;

  void _pickImage(File? image) {
    if (image != null) {
      _userImageFile = image;
    }
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please pick an image')));
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitAuth(
        _userEmail.trim(),
        _userName.trim(),
       _userImageFile?? File(''),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }
@override
  void initState() {
    // final s =FirebaseMessaging.;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(18),
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
                        imagePickedFn: _pickImage,
                      ),
                    TextFormField(
                      autofillHints: const [AutofillHints.email],
                      key: const ValueKey('email'),
                      textInputAction: TextInputAction.next,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _userEmail = newValue;
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        autofillHints: const [AutofillHints.name],
                        textInputAction: TextInputAction.next,
                        key: const ValueKey('username'),
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _userName = newValue;
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters.';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                      ),
                    TextFormField(autofillHints: const [AutofillHints.password],
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _submit,
                      key: const ValueKey('password'),
                      onSaved: (newValue) {
                        if (newValue != null) {
                          _userPassword = newValue;
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Please enter at least 6 characters. ';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submit,
                            child: Text(_isLogin ? 'Log In' : 'Sign Up')),
                    if (!widget.isLoading)
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create New Account'
                              : 'I already have an account'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
