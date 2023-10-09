import 'package:flutter/material.dart';
import 'package:my_shop/providers/auth.dart';
import 'package:my_shop/services/http_exception.dart';
import 'package:provider/provider.dart';

///
/// @Author: "Eldor Turgunov"
/// @Date: 09.10.2023
///

enum AuthMode {
  Register,
  Login,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey();

  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  var _loading = false;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Xatolik'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();

      setState(() {
        _loading = true;
      });
      try {
        if (_authMode == AuthMode.Login) {
          await Provider.of<Auth>(context, listen: false).logIn(
            _authData['email']!,
            _authData['password']!,
          );
        } else {
          await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email']!,
            _authData['password']!,
          );
        }
      } on HttpException catch (error) {
        var errorMessage = 'Xatolik sodir bo\'ldi';
        if (error.message.contains('EMAIL_EXISTS')) {
          errorMessage = 'Email band';
        } else if (error.message.contains('INVALID_EMAIL')) {
          errorMessage = 'To\'g\'ri email kiriting';
        } else if (error.message.contains('WEAK_PASSWORD')) {
          errorMessage = 'Juda oson parol';
        } else if (error.message.contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Email topilmadi';
        } else if (error.message.contains('INVALID_PASSWORD')) {
          errorMessage = 'Parol noto\'g\'ri';
        }
        _showErrorDialog(errorMessage);
      } catch (e) {
        var errorMessage = 'Qayta urinib ko\'ring';
        _showErrorDialog(errorMessage);
      }
      setState(() {
        _loading = false;
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Register;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email or number',
                        ),
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Email manzil kiriting';
                          } else if (!email.contains('@')) {
                            return 'To\'g\'ri email kiriting';
                          }
                          return null;
                        },
                        onSaved: (email) {
                          _authData['email'] = email!;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Parol kiriting';
                          } else if (password.length < 6) {
                            return 'Parol juda oson!';
                          }
                          return null;
                        },
                        onSaved: (password) {
                          _authData['password'] = password!;
                        },
                      ),
                      if (_authMode == AuthMode.Register)
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Retry Password',
                              ),
                              validator: (confirmPassword) {
                                if (_passwordController.text !=
                                    confirmPassword) {
                                  return 'Parol mos kelmadi';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      const SizedBox(height: 60),
                      _loading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Text(
                                _authMode == AuthMode.Login
                                    ? 'KIRISH'
                                    : 'Ro\'yxatdan o\'tish',
                              ),
                            ),
                      const SizedBox(height: 40),
                      TextButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                          _authMode == AuthMode.Login
                              ? 'Ro\'yxatdan o\'tish'
                              : 'Kirish',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
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
