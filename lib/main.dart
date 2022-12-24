import 'dart:async';
import 'package:custom_metronome/sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:custom_metronome/tempo.dart';
import 'package:custom_metronome/globals.dart';
import 'package:custom_metronome/metronomes.dart';
import 'package:custom_metronome/settings.dart';

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
      routes: {
        '/tempo': (context) => const EditTempo(),
        '/section': (context) => const EditSection(),
        '/metronome': (context) => const EditMetronome(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // load shared prefs
  void loadSharedPrefs() async {
    try {
      UserData user = UserData.fromJson(await sharedPref.read("user"));
      debugPrint(user.toString());
      setState(() {
        userData = user;
        switchMetronome(user.currentIndex);
      });
      debugPrint('loaded');
      // ignore: non_constant_identifier_names
    } catch (e) {
      debugPrint('nothing found');
      debugPrint(e.toString());
    }
  }

  // colors
  var playColor = Colors.black;
  // metronome bool
  bool isMute = false;
  bool isPlaying = false;
  // lists
  List<BoxShadow> boxShadows = [];
  // values
  int activeMetronome =
      getMetronomeIndex(metronomes, userMeasure); // index of active metronome

  int tempoPercent =
      100; // The tempo as a percent (e.g. 100 = normal tempo, 50 = half tempo)
  int beat = 1; // current beat
  int measure = userMeasure; // total measures played
  int leadInMeasure = 1; // lead in measures played
  int currentMeasure = getCurrentMeasure(
      metronomes, userMeasure); // current measure of metronome object

  //timer
  Timer timer = Timer.periodic(
      Duration(milliseconds: (60 / 120 * 1000).round()), (timer) {});

  //audio files
  var soundPlayer = SoundPlayer(); // Create a SoundPlayer instance

  // soundplayer object ids
  int high = 0;
  int low = 0;

  void showEditSectionStart(
      BuildContext context, int index, List<Section> sections) {
    final sectionController = TextEditingController(text: sections[index].name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Section Start'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField(
                items: getSectionNames(sections).map((section) {
                  return DropdownMenuItem(
                    value: section,
                    child: Text(section),
                  );
                }).toList(),
                onChanged: (value) {
                  sectionController.text = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Section',
                  hintText: 'Select a section',
                ),
                value: sectionController.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userMeasure =
                      getSectionMeasure(sections, sectionController.text);
                  measure = userMeasure;
                  currentMeasure = getCurrentMeasure(metronomes, userMeasure);
                  activeMetronome = getMetronomeIndex(metronomes, userMeasure);
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showEditMeasureStart(BuildContext context, int startMeasure) {
    final measureController =
        TextEditingController(text: startMeasure.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Measure Start'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(getTotalRange(metronomes)),
              TextFormField(
                controller: measureController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: 'Measure',
                  hintText: 'Enter a measure',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // check if measure is in range
                if (int.parse(measureController.text) >
                    getTotalMeasures(metronomes)) {
                  // check if totalMeasures is 0
                  if (getTotalMeasures(metronomes) == 0) {
                    setState(() {
                      userMeasure = int.parse(measureController.text);
                      measure = userMeasure;
                      currentMeasure =
                          getCurrentMeasure(metronomes, userMeasure);
                      activeMetronome =
                          getMetronomeIndex(metronomes, userMeasure);
                    });
                    Navigator.pop(context);
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Measure is out of range'),
                    ),
                  );
                  return;
                }
                // check if measure is less than 1
                if (int.parse(measureController.text) < 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Measure must be greater than 0'),
                    ),
                  );
                  return;
                }
                // check if measure is 0
                if (int.parse(measureController.text) == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Measure must be greater than 0'),
                    ),
                  );
                  return;
                }
                setState(() {
                  userMeasure = int.parse(measureController.text);
                  measure = userMeasure;
                  currentMeasure = getCurrentMeasure(metronomes, userMeasure);
                  activeMetronome = getMetronomeIndex(metronomes, userMeasure);
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void switchMetronome(int index) {
    setState(() {
      // userdata
      userData.currentIndex = index;
      // globals
      metronomes = userData.metronomeData[index].metronomes;
      sections = userData.sectionData[index].sections;
      // local values
      userMeasure = 1;
      measure = userMeasure;
      currentMeasure = 1;
      activeMetronome = 0;
    });
  }

  void showSwitchMetronome(BuildContext context) {
    final metronomeController = TextEditingController(
        text: userData.metronomeData[userData.currentIndex].name);
    int selectedIndex = userData.currentIndex;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Switch Metronome'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField(
                items: getMetronomeNames().map(
                  (metronome) {
                    return DropdownMenuItem(
                      value: metronome,
                      child: Text(metronome),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  metronomeController.text = value!;
                  selectedIndex = getMetronomeIndexByName(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Metronome',
                  hintText: 'Select a metronome',
                ),
                value: metronomeController.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  switchMetronome(selectedIndex);
                });

                // save changes
                sharedPref.save("user", userData);

                Navigator.pop(context);
              },
              child: const Text('Switch'),
            ),
          ],
        );
      },
    );
  }

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

  void leadInParms() {
    setState(() {
      boxShadows[beat - 1] = const BoxShadow(
        color: Colors.cyanAccent,
        blurRadius: 12.0,
        spreadRadius: 8.0,
      );
    });
    if (beat != userData.leadInMetronome.beatsPerMeasure) {
      // not first beat
      soundPlayer.play(low);
      beat += 1;
    } else {
      // first beat
      soundPlayer.play(high);
      beat = 1;
      // if not the last measure
      if (userData.leadInMetronome.measures != leadInMeasure) {
        leadInMeasure += 1;
      } else {
        // last measure, start up the metronome
        debugPrint('here');
        timer.cancel();
        timer = Timer.periodic(
            Duration(
                milliseconds: (getTime(metronomes[activeMetronome].tempo,
                    tempoPercent, metronomes[activeMetronome].timeSignature))),
            (timer) => timerParms());
      }
    }
  }

  void timerParms() {
    {
      setState(() {
        boxShadows[beat - 1] = const BoxShadow(
          color: Colors.cyanAccent,
          blurRadius: 12.0,
          spreadRadius: 8.0,
        );
      });
      if (beat != metronomes[activeMetronome].beatsPerMeasure) {
        soundPlayer.play(low);
        beat += 1;
      } else {
        // if metronome is not the last one
        if (activeMetronome != metronomes.length - 1) {
          soundPlayer.play(high);
        } else {
          // metronome is the last one
          // if not the last measure
          if (currentMeasure != metronomes[activeMetronome].measures) {
            soundPlayer.play(high);
          }
        }
        beat = 1;
        // if metronome is not infinite
        if (metronomes[activeMetronome].measures != 0) {
          // if metronome is not finished
          if (metronomes[activeMetronome].measures != currentMeasure) {
            currentMeasure += 1;
            measure += 1;
          } else // metronome is finished
          {
            // if there are more metronomes
            if (activeMetronome != metronomes.length - 1) {
              activeMetronome += 1;
              // restart timer for new metronome
              timer.cancel();
              timer = Timer.periodic(
                  Duration(
                      milliseconds: (getTime(
                          metronomes[activeMetronome].tempo,
                          tempoPercent,
                          metronomes[activeMetronome].timeSignature))),
                  (timer) => timerParms());
              currentMeasure = 1;
              measure += 1;
            } else // there are no more metronomes
            {
              // pause play button
              isPlaying = false;
              // stop the timer
              timer.cancel();
              // reset the metronome
              currentMeasure = getCurrentMeasure(metronomes, userMeasure);
              measure = userMeasure;
              beat = 1;
              leadInMeasure = 1;
              activeMetronome = getMetronomeIndex(metronomes, userMeasure);
            }
          }
        } else {
          // metronome is infinite
          currentMeasure += 1;
          measure += 1;
        }
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
    // load user data
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            showSwitchMetronome(context);
          },
          child: FittedBox(
              child:
                  Text((userData.metronomeData[userData.currentIndex].name))),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/metronome');
            },
            icon: const Icon(Icons.save),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              setState(
                () {
                  String name = getMetronomeName(defaultMetronomeName);

                  userData.metronomeData.add(
                    CustomMetronome(
                      name: name,
                      metronomes: [
                        Metronome(
                          tempo: defaultTempo,
                          beatsPerMeasure: defaultBeatsPerMeasure,
                          timeSignature: defaultTimeSignature,
                          measures: defaultMeasures,
                        ),
                      ],
                    ),
                  );

                  userData.sectionData.add(CustomSection(sections: [
                    Section(),
                  ]));
                },
              );
              switchMetronome(userData.metronomeData.length - 1);
            },
            icon: const Icon(Icons.add_box),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (isMute) {
                  soundPlayer.setVolume(high, 1.0);
                  soundPlayer.setVolume(low, 1.0);
                } else {
                  soundPlayer.setVolume(high, 0.0);
                  soundPlayer.setVolume(low, 0.0);
                }
                isMute = !isMute;
              });
            },
            icon: Icon(isMute ? Icons.volume_mute : Icons.volume_up),
            color: isMute ? Colors.teal : Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings),
            color: Colors.white,
          ),
        ],
      ),
      body: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // blue line
                Container(
                  padding: const EdgeInsets.all(2.0),
                  color: Colors.cyan,
                ),
                // metronome display
                Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.black,
                  width: double.infinity,
                  height: newheight * 0.25,
                  child: Center(
                    child: Column(
                      mainAxisAlignment:
                          metronomes[activeMetronome].beatsPerMeasure < 6
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceEvenly,
                      children: [
                        //metronome less than 6 beats
                        if (metronomes[activeMetronome].beatsPerMeasure < 6)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (var i = 0;
                                  i <
                                      metronomes[activeMetronome]
                                          .beatsPerMeasure;
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
                          )
                        else
                          // metronome greater than 6 beats
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (var i = 0; i < 6; i++)
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var i = 6;
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
                        )
                      ],
                    ),
                  ),
                ),
                // metronome controls
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
                            children: [
                              const Text('BPM'),
                              Text(
                                '${(metronomes[activeMetronome].tempo)}',
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('Time Signature'),
                              Text(
                                '${(metronomes[activeMetronome].beatsPerMeasure)}'
                                '/${(metronomes[activeMetronome].timeSignature)}',
                                style: const TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/tempo');
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
                  height: newheight * 0.12,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 5.0),
                    height: newheight * 0.12,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                showEditSectionStart(
                                    context,
                                    getSectionIndex(sections, measure),
                                    sections);
                              },
                              child: const Text('Section▼'),
                            ),
                            Text(
                              getSection(sections, measure),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                showEditMeasureStart(context, measure);
                              },
                              child: const Text('Measure▼'),
                            ),
                            Text(
                              '$measure',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/section');
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ),
                // TODO AD space
                Container(
                  color: Colors.black12,
                  height: newheight * (height < 512 ? 0.13 : 0.23) - 80,
                ),
                // play controls
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
                                                      metronomes[
                                                              activeMetronome]
                                                          .tempo,
                                                      tempoPercent,
                                                      metronomes[
                                                              activeMetronome]
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
                                                      metronomes[
                                                              activeMetronome]
                                                          .tempo,
                                                      tempoPercent,
                                                      metronomes[
                                                              activeMetronome]
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
                                  leadInMeasure = 1;
                                  measure = userMeasure;
                                  currentMeasure = getCurrentMeasure(
                                      metronomes, userMeasure);
                                  activeMetronome = getMetronomeIndex(
                                      metronomes, userMeasure);
                                } else {
                                  // start
                                  soundPlayer.play(high);
                                  isPlaying = true;
                                  if (userData.leadIn) {
                                    timer = Timer.periodic(
                                        Duration(
                                            milliseconds: (getTime(
                                                userData.leadInMetronome.tempo,
                                                tempoPercent,
                                                userData.leadInMetronome
                                                    .timeSignature))),
                                        (timer) => leadInParms());
                                  } else {
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
                              isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded,
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
        ),
      ),
    );
  }
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
