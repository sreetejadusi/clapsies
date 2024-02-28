import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  double tipOpacity = 1.0;
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
          ..repeat();
    controller?.stop();
    player.setAsset('assets/clap.mpeg');
    player.positionStream.listen((event) {
      if (event == player.duration) {
        player.stop();
        player.load();
      }
    });
    player.playingStream.listen((event) {
      if (event) {
        controller?.repeat();
      } else {
        controller?.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primaryContainer,
          Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
          Colors.transparent
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 50,
              child: Text(
                'Clapsies',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontFamily: GoogleFonts.bangers.call().fontFamily,
                      letterSpacing: 1.5,
                      fontSize: 48,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {
                tipOpacity = 0;
                // player.load();
                player.play();
                setState(() {});
              },
              child: AnimatedEmoji(
                AnimatedEmojis.clap,
                controller: controller,
                size: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.25,
              child: AnimatedOpacity(
                opacity: tipOpacity,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'tap on the clapping hands to clap!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              child: GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse('https://github.com/sreetejadusi/clapsies'));
                },
                child: Column(
                  children: [
                    const Text(
                      'open-source on,',
                      style: TextStyle(fontSize: 10),
                    ),
                    Image.asset(
                      'assets/github.png',
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
