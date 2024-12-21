import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SevenDayForecastCard extends StatelessWidget {
  final String day;
  final int minTemp;
  final int maxTemp;
  final IconData weatherIcon;
  final Size size;
  final bool isDarkMode;

  const SevenDayForecastCard({
    super.key,
    required this.day,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherIcon,
    required this.size,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.005),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(
                  day,
                  style: GoogleFonts.questrial(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                child: FaIcon(
                  weatherIcon,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.height * 0.03,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.15),
                  child: Text(
                    '$minTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white38 : Colors.black38,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Text(
                    '$maxTemp˚C',
                    style: GoogleFonts.questrial(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: size.height * 0.025,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: isDarkMode ? Colors.white : Colors.black),
        ],
      ),
    );
  }
}
