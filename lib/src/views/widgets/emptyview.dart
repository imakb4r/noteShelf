import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:note_shelf/src/res/assets.dart';

class EmpptyView extends StatelessWidget {
  const EmpptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AnimationsAssets.empty),
          Text(
            "Things look empty here. Tap + to start",
            style: GoogleFonts.poppins(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
