import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/providers/user_provider.dart';

import 'package:pokedex/services/setup_service.dart';
import 'package:provider/provider.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  // final _usernameController = TextEditingController();
  String? _selectedType;
  String? _backgroundImage;
  bool _isUsernameValid = false;
  bool _isCheckingUsername = false;
  String _usernameError = '';

  final user = FirebaseAuth.instance.currentUser;

  void handleContinue() {
    final username = context.read<UserProvider>().username;
    SetupService.handleContinueLogic(
      context: context,
      selectedType: _selectedType,
      backgroundImage: _backgroundImage ?? '',
      username: username,
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _backgroundImage != null
              ? Opacity(
                opacity: 0.85,
                child: Image.asset(
                  _backgroundImage!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              )
              : Container(color: Colors.white),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 80.0,
                left: 10,
                right: 10,
                bottom: 30,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset('assets/images/profelm.png'),
                      ),
                      Expanded(
                        child: Text(
                          "To infinity and beyond",
                          style: GoogleFonts.vt323(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 44),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),

                    child: Consumer<UserProvider>(
                      builder:
                          (_, userProvider, __) => TextField(
                            onChanged: (val) async {
                              final username = val.trim();

                              setState(() {
                                _isUsernameValid = false;
                                _isCheckingUsername = true;
                                _usernameError = '';
                              });

                              if (username.length < 8) {
                                setState(() {
                                  _usernameError =
                                      'Username must be at least 8 characters';
                                  _isCheckingUsername = false;
                                });
                                return;
                              }

                              final taken = await SetupService.isUsernameTaken(
                                username,
                              );

                              setState(() {
                                _isCheckingUsername = false;
                                if (taken) {
                                  _usernameError = 'Username is already taken';
                                } else {
                                  _isUsernameValid = true;
                                }
                              });

                              context.read<UserProvider>().setUsername(
                                username,
                              );
                            },

                            style: GoogleFonts.vt323(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'What should we call you?',
                              hintStyle: GoogleFonts.vt323(fontSize: 20),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2.5,
                                  color: Colors.amberAccent,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                    ),
                  ),
                  if (_usernameError.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _usernameError,
                        style: const TextStyle(color: Color.fromARGB(255, 255, 17, 0)),
                      ),
                    ),

                  const SizedBox(height: 35),
                  Text(
                    'Choose your starter type',
                    style: GoogleFonts.vt323(fontSize: 27),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTypeCard("Fire", "assets/images/firecard.png"),
                      _buildTypeCard("Water", "assets/images/watercard.png"),
                      _buildTypeCard("Grass", "assets/images/grasscard.png"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Will be with you FOREVER",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed:
                        (_isUsernameValid && _selectedType != null)
                            ? handleContinue
                            : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      "continue",
                      style: GoogleFonts.vt323(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(String type, String imgPath) {
    final isSelected = _selectedType == type;

    final glowColor = switch (type) {
      "Fire" => Colors.redAccent,
      "Water" => Colors.blueAccent,
      "Grass" => Colors.greenAccent,
      _ => Colors.amberAccent,
    };

    return GestureDetector(
      onTap:
          () => setState(() {
            _selectedType = type;

            _backgroundImage = switch (type) {
              "Fire" => "assets/images/redbg.png",
              "Water" => "assets/images/bluebg.png",
              "Grass" => "assets/images/greenbg.png",
              _ => null,
            };
          }),

      child: Container(
        width: 115,
        height: 150,
        decoration: BoxDecoration(
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: glowColor,
                      blurRadius: 25,
                      spreadRadius: 3,
                      offset: const Offset(0, 0),
                    ),
                  ]
                  : [],
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(imgPath, fit: BoxFit.cover),
      ),
    );
  }
}
