import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
// import 'package:custom_metronome/tempocpt.dart';
import 'package:custom_metronome/tempo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // colors
  var playColor = Colors.black;
  // metronome bool
  bool isMute = false;
  bool isPlaying = false;
  // lists
  List<BoxShadow> boxShadows = [];
  // values
  List<Metronome> metronomes = [
    Metronome(
      tempo: 120,
      beatsPerMeasure: 3,
      timeSignature: 4,
      measures: -1,
    ),
  ];
  int activeMetronome = 0; // index of active metronome

  int tempoPercent =
      100; // The tempo as a percent (e.g. 100 = normal tempo, 50 = half tempo)
  int beat = 1; // current beat
  int totalMeasures = 0; // total measures played
  int currentMeasure = 0; // current measure of metronome object

  //timer
  Timer timer = Timer.periodic(
      Duration(milliseconds: (60 / 120 * 1000).round()), (timer) {});

  //audio files
  var soundPlayer = SoundPlayer(); // Create a SoundPlayer instance

  // soundplayer object ids
  int high = 0;
  int low = 0;

  // Load the first sound file into the cache
  void loadSounds() async {
    high = await soundPlayer.load('assets/Synth_Bell_A_hi.wav');
    low = await soundPlayer.load('assets/Synth_Bell_A_lo.wav');
  }

  int getTime(tempo, tempoPercent, timeSignature) {
    int time = (60 / tempo * 1000 * (100 / tempoPercent) / (timeSignature / 4))
        .round();

    return time;
  }

  void timerParms() {
    {
      if (beat != metronomes[activeMetronome].beatsPerMeasure) {
        setState(() {
          beat += 1;
          boxShadows[beat - 1] = const BoxShadow(
            color: Colors.cyanAccent,
            blurRadius: 12.0,
            spreadRadius: 8.0,
          );
        });
        soundPlayer.play(low);
      } else {
        setState(() {
          beat = 1;
          boxShadows[beat - 1] = const BoxShadow(
            color: Colors.cyanAccent,
            blurRadius: 12.0,
            spreadRadius: 8.0,
          );
        });
        soundPlayer.play(high);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // load boxShadows
    for (var i = 0; i < metronomes.length; i++) {
      for (var j = 0; j < metronomes[i].beatsPerMeasure; j++) {
        boxShadows.add(
          const BoxShadow(),
        );
      }
    }
    // Load the sound files when the widget is initialized
    loadSounds();
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Untitled'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isMute = !isMute;
              });
            },
            icon: Icon(isMute ? Icons.volume_mute : Icons.volume_up),
            color: isMute ? Colors.teal : Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Colors.white,
          ),
        ],
      ),
      body: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              color: Colors.cyan,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.black,
              width: double.infinity,
              height: newheight * 0.25,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0;
                        i < metronomes[activeMetronome].beatsPerMeasure;
                        i++)
                      Container(
                        padding: const EdgeInsets.all(45.0),
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: isPlaying
                              ? boxShadows
                                  .map((shadow) => i == (beat - 1)
                                      ? shadow
                                      : const BoxShadow())
                                  .toList()
                              : [],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                height: newheight * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [Text('Measure'), Text('1')],
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [Text('Time Signature'), Text('4/4')],
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const MyTempo();
                            },
                          ));
                        },
                        icon: const Icon(Icons.edit),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: newheight * (height < 512 ? 0.25 : 0.35) - 80,
            ),
            Container(
              color: Colors.black12,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                height: newheight * (height < 512 ? 0.35 : 0.25),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                // 40 is min
                                if (tempoPercent != 40) {
                                  setState(() {
                                    tempoPercent -= 1;
                                    if (isPlaying) {
                                      timer.cancel();
                                      timer = Timer.periodic(
                                          Duration(
                                              milliseconds: (getTime(
                                                  metronomes[activeMetronome]
                                                      .tempo,
                                                  tempoPercent,
                                                  metronomes[activeMetronome]
                                                      .timeSignature))),
                                          (timer) => timerParms());
                                    }
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 45,
                              )),
                          Text(
                            '${(tempoPercent)}%',
                            style: const TextStyle(fontSize: 25),
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                // 200 is max
                                if (tempoPercent != 200) {
                                  setState(() {
                                    tempoPercent += 1;
                                    if (isPlaying) {
                                      timer.cancel();
                                      timer = Timer.periodic(
                                          Duration(
                                              milliseconds: (getTime(
                                                  metronomes[activeMetronome]
                                                      .tempo,
                                                  tempoPercent,
                                                  metronomes[activeMetronome]
                                                      .timeSignature))),
                                          (timer) => timerParms());
                                    }
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 45,
                              )),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        color: playColor,
                        onPressed: () {
                          setState(() {
                            if (isPlaying) {
                              // stop
                              timer.cancel();
                              isPlaying = false;
                              beat = 1;
                            } else {
                              // start
                              soundPlayer.play(high);
                              isPlaying = true;
                              timer = Timer.periodic(
                                  Duration(
                                      milliseconds: (getTime(
                                          metronomes[activeMetronome].tempo,
                                          tempoPercent,
                                          metronomes[activeMetronome]
                                              .timeSignature))),
                                  (timer) => timerParms());
                            }
                            playColor = Colors.cyan;
                          });
                          Timer(const Duration(milliseconds: 100), () {
                            setState(() {
                              playColor = Colors.black;
                            });
                          });
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                        ),
                        iconSize: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Metronome {
  // beats per minute
  int tempo;

  // number of beats per measure, for example the 3 in 3/4
  int beatsPerMeasure;

  // bottom of the time signature, for example the 4 in 3/4
  int timeSignature;

  // number of measures to play, with -1 indicating infinite measures
  int measures;

  Metronome({
    this.tempo = 120,
    this.beatsPerMeasure = 4,
    this.timeSignature = 4,
    this.measures = -1,
  });
}

class SoundPlayer {
  // Create a Soundpool instance
  final soundpool = Soundpool.fromOptions();

  // Load a sound file into the cache
  Future<int> load(String filePathOrUrl) async {
    // Convert the file path or URL to a ByteData object
    var byteData = await rootBundle.load(filePathOrUrl);

    // Load the sound file into the cache
    return await soundpool.load(byteData);
  }

  // Play a sound
  Future<void> play(int soundId) async {
    await soundpool.play(soundId);
  }

  // Set the volume of a sound (between 0.0 and 1.0)
  Future<void> setVolume(int soundId, double volume) async {
    await soundpool.setVolume(soundId: soundId, volume: volume);
  }
}
