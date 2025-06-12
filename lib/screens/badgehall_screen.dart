import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/models/badge_model.dart'; // your kantoBadges list

class BadgeHallScreen extends StatelessWidget {
  const BadgeHallScreen({super.key});
  Color getBgColor(String type) {
    switch (type.toLowerCase()) {
      case 'rock':
        return const Color(0xFFF5F0EB); // pale stone beige
      case 'water':
        return const Color(0xFFE1F5FE); // soft sky blue
      case 'electric':
        return const Color(0xFFFFF9C4); // light lemon yellow
      case 'grass':
        return const Color(0xFFE8F5E9); // light minty green
      case 'poison':
        return const Color(0xFFF3E5F5); // soft lavender
      case 'psychic':
        return const Color(0xFFFCE4EC); // pale pink
      case 'fire':
        return const Color(0xFFFFEBEE); // very light coral red
      case 'ground':
        return const Color(0xFFEFEBE9); // light clay beige
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: kantoBadges.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final badge = kantoBadges[index];
              final bgColor = getBgColor(badge['type']!);
              return Container(
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(badge['badgeImage']!, height: 150),
                          // SizedBox(width: 30),
                          Image.asset(badge['leaderImage']!, height: 180),
                        ],
                      ),
                      // SizedBox(height: 10),
                      Text(
                        badge['badgeName']!,
                        style: GoogleFonts.pressStart2p(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '"${badge['quote']!}"',
                          style: GoogleFonts.vt323(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // const SizedBox(height: 20),
                      Column(
                        children: [
                          Text(
                            'Gym Leader: ${badge['leader']}',
                            style: GoogleFonts.vt323(
                              fontSize: 22,
                              // fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            'City: ${badge['city']}',
                            style: GoogleFonts.vt323(
                              fontSize: 22,
                              // fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            'Type: ${badge['type']}',
                            style: GoogleFonts.vt323(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${badge['funFact']}',
                          style: GoogleFonts.amarante(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          kantoBadges.length,
                          (dotIndex) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 10,
                            ),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  dotIndex == index
                                      ? Colors.black
                                      : Colors.black26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 42,
            left: 11,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 32),
              onPressed: () {
                Navigator.pop(context); // Goes back to HomeScreen
              },
            ),
          ),
        ],
      ),
    );
  }
}
