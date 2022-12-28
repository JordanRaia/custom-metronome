// global variable that holds the List of Metronome objects
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// metronome icon
const IconData metronome = IconData(0xf70b,
    fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons');

// example metronome
List<Metronome> exampleMetronome = [
  Metronome(
    tempo: 138,
    beatsPerMeasure: 4,
    timeSignature: 4,
    measures: 14,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 4,
    timeSignature: 4,
    measures: 5,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 4,
    timeSignature: 4,
    measures: 15,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 2,
    timeSignature: 4,
    measures: 35,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 3,
    timeSignature: 4,
    measures: 1,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 2,
    timeSignature: 4,
    measures: 3,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 3,
    timeSignature: 4,
    measures: 1,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 2,
    timeSignature: 4,
    measures: 13,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 3,
    timeSignature: 4,
    measures: 1,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 2,
    timeSignature: 4,
    measures: 5,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 2,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 3,
    timeSignature: 16,
    measures: 1,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 2,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 4,
    timeSignature: 4,
    measures: 10,
  ),
  Metronome(
    tempo: 126,
    beatsPerMeasure: 4,
    timeSignature: 4,
    measures: 4,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 4,
    timeSignature: 4,
    measures: 22,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 4,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 3,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 5,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 4,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 3,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 5,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 4,
    timeSignature: 8,
    measures: 1,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 3,
    timeSignature: 4,
    measures: 2,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 6,
    timeSignature: 8,
    measures: 2,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 5,
    timeSignature: 8,
    measures: 3,
  ),
  Metronome(
    tempo: 138,
    beatsPerMeasure: 6,
    timeSignature: 8,
    measures: 4,
  ),
];

// example section
List<Section> exampleSection = [
  Section(
    name: 'Intro',
    measures: 6,
  ),
  Section(
    name: 'Rehersal 1',
    measures: 8,
  ),
  Section(
    name: 'Rehersal 2',
    measures: 5,
  ),
  Section(
    name: 'Rehersal 3',
    measures: 7,
  ),
  Section(
    name: 'Rehersal 4',
    measures: 7,
  ),
  Section(
    name: 'Rehersal 5',
    measures: 9,
  ),
  Section(
    name: 'Rehersal 6',
    measures: 8,
  ),
  Section(
    name: 'Rehersal 7',
    measures: 7,
  ),
  Section(
    name: 'Rehersal 8',
    measures: 10,
  ),
  Section(
    name: 'Rehersal 9',
    measures: 11,
  ),
  Section(
    name: 'Rehersal 10',
    measures: 9,
  ),
  Section(
    name: 'Rehersal 11',
    measures: 9,
  ),
  Section(
    name: 'Rehersal 12',
    measures: 10,
  ),
  Section(
    name: 'Rehersal 13',
    measures: 8,
  ),
  Section(
    name: 'Rehersal 14',
    measures: 8,
  ),
  Section(
    name: 'Rehersal 15',
    measures: 6,
  ),
  Section(
    name: 'Rehersal 16',
    measures: 7,
  ),
  Section(
    name: 'Rehersal 17',
    measures: 8,
  ),
  Section(
    name: 'Rehersal 18',
    measures: 7,
  ),
];

UserData userData = UserData(
  currentIndex: 0,
  leadIn: false,
  leadInMetronome: Metronome(
    measures: 1,
  ),
  metronomeData: [
    CustomMetronome(name: 'Example Metronome', metronomes: exampleMetronome),
  ],
  sectionData: [
    CustomSection(sections: exampleSection),
  ],
);

List<Metronome> metronomes =
    userData.metronomeData[userData.currentIndex].metronomes;

List<Section> sections = userData.sectionData[userData.currentIndex].sections;

// Metronome leadInMetronome = userData.leadInMetronome;

class UserData {
  // all the user's saved metronomes
  List<CustomMetronome> metronomeData;

  // all the user's saved sections
  List<CustomSection> sectionData;

  // the user's current metronome and section
  int currentIndex;

  // bool for if the user wants to play a lead in
  bool leadIn;

  // the lead in metronome
  Metronome leadInMetronome;

  UserData({
    this.currentIndex = 0,
    this.metronomeData = const [],
    this.sectionData = const [],
    this.leadIn = false,
    required this.leadInMetronome,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : currentIndex = json['currentIndex'],
        leadIn = json['leadIn'],
        leadInMetronome = Metronome.fromJson(json['leadInMetronome']),
        metronomeData = json['metronomeData']
            .map<CustomMetronome>((m) => CustomMetronome.fromJson(m))
            .toList(),
        sectionData = json['sectionData']
            .map<CustomSection>((s) => CustomSection.fromJson(s))
            .toList();

  Map<String, dynamic> toJson() => {
        'currentIndex': currentIndex,
        'leadIn': leadIn,
        'leadInMetronome': leadInMetronome.toJson(),
        'metronomeData': metronomeData.map((m) => m.toJson()).toList(),
        'sectionData': sectionData.map((s) => s.toJson()).toList(),
      };

  @override
  String toString() {
    return 'UserData{currentIndex: $currentIndex, '
        'metronomeData: $metronomeData';
  }
}

List<String> getMetronomeNames() {
  List<String> metronomeNames = [];
  for (int i = 0; i < userData.metronomeData.length; i++) {
    metronomeNames.add(userData.metronomeData[i].name);
  }
  return metronomeNames;
}

int getMetronomeIndexByName(String name) {
  for (int i = 0; i < userData.metronomeData.length; i++) {
    if (userData.metronomeData[i].name == name) {
      return i;
    }
  }
  return 0;
}

// metronome object
class Metronome {
  // beats per minute
  int tempo;

  // number of beats per measure, for example the 3 in 3/4
  int beatsPerMeasure;

  // bottom of the time signature, for example the 4 in 3/4
  int timeSignature;

  // number of measures to play, with 0 indicating infinite measures
  int measures;

  Metronome({
    this.tempo = defaultTempo,
    this.beatsPerMeasure = defaultBeatsPerMeasure,
    this.timeSignature = defaultTimeSignature,
    this.measures = defaultMeasures,
  });

  Metronome.fromJson(Map<String, dynamic> json)
      : tempo = json['tempo'],
        beatsPerMeasure = json['beatsPerMeasure'],
        timeSignature = json['timeSignature'],
        measures = json['measures'];

  Map<String, dynamic> toJson() => {
        'tempo': tempo,
        'beatsPerMeasure': beatsPerMeasure,
        'timeSignature': timeSignature,
        'measures': measures,
      };

  @override
  String toString() {
    return 'Metronome{tempo: $tempo, beatsPerMeasure: $beatsPerMeasure, '
        'timeSignature: $timeSignature, measures: $measures}';
  }
}

// custom metronome object
class CustomMetronome {
  // name of the custom metronome
  String name;

  // list of the individual metronomes
  List<Metronome> metronomes;

  CustomMetronome({
    this.name = 'Untitled Metronome',
    this.metronomes = const [],
  });

  CustomMetronome.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        metronomes = json['metronomes']
            .map<Metronome>((m) => Metronome.fromJson(m))
            .toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'metronomes': metronomes.map((m) => m.toJson()).toList(),
      };

  @override
  String toString() {
    return 'CustomMetronome{name: $name, metronomes: $metronomes}';
  }
}

// get the measure range for a metronome
String getMeasureRangeMetronome(List<Metronome> metronomes, int index) {
  int totalMeasures = 0;
  for (int i = 0; i < metronomes.length; i++) {
    // not the current metronome
    if (i != index) {
      totalMeasures += metronomes[i].measures;
    } else // current metronome
    {
      String range = '';
      if (metronomes[i].measures != 0) {
        if ((totalMeasures + 1) != (totalMeasures + metronomes[i].measures)) {
          range =
              '${(totalMeasures + 1)} - ${totalMeasures + metronomes[i].measures}';
        } else {
          range = '${(totalMeasures + 1)}';
        }
      } else {
        range = '${(totalMeasures + 1)} - ∞';
      }

      return range;
    }
  }

  // error
  debugPrint('Error: getMeasureRange(): index out of range');
  return '';
}

String getTotalRange(List<Metronome> metronomes) {
  int totalMeasures = getTotalMeasures(metronomes);
  String range = '';
  if (totalMeasures != 0) {
    range = '1 - $totalMeasures';
  } else {
    range = '1 - ∞';
  }

  return range;
}

int getTotalMeasures(List<Metronome> metronomes) {
  int totalMeasures = 0;
  for (int i = 0; i < metronomes.length; i++) {
    totalMeasures += metronomes[i].measures;
  }

  return totalMeasures;
}

List<String> getStringMeasures(List<Metronome> metronomes) {
  int totalMeasures = getTotalMeasures(metronomes);
  List<String> stringMeasures = [];
  for (int i = 0; i < totalMeasures; i++) {
    stringMeasures.add('${i + 1}');
  }

  return stringMeasures;
}

int getCurrentMeasure(List<Metronome> metronomes, int measure) {
  int totalMeasures = 0;
  for (int i = 0; i < metronomes.length; i++) {
    totalMeasures += metronomes[i].measures;
    if (measure <= totalMeasures) {
      // subtract the total measures from the current measure
      totalMeasures = totalMeasures - metronomes[i].measures;
      // get the current measure
      int currentMeasure = measure - totalMeasures;
      // return
      return currentMeasure;
    }
  }

  // error
  debugPrint('Error: getCurrentMeasure(): measure out of range $measure');
  return -1;
}

int getMetronomeIndex(List<Metronome> metronomes, int measure) {
  int totalMeasures = 0;
  for (int i = 0; i < metronomes.length; i++) {
    totalMeasures += metronomes[i].measures;
    if (measure <= totalMeasures) {
      return i;
    }
  }

  // error
  debugPrint('Error: getMetronomeIndex(): measure out of range $measure');
  return 0;
}

// default metronome
const int defaultTempo = 120;
const int defaultBeatsPerMeasure = 4;
const int defaultTimeSignature = 4;
const int defaultMeasures = 0;

// default custom metronome
const String defaultMetronomeName = 'Untitled Metronome';

// user start time
int userMeasure = 1;

// section object
class Section {
  // name of the section
  String name;

  // number of measures in the section, 0 indicates infinite measures
  int measures;

  Section({
    this.name = defaultName,
    this.measures = defaultMeasures,
  });

  Section.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        measures = json['measures'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'measures': measures,
      };
}

// custom Section object
class CustomSection {
  // list of the individual sections
  List<Section> sections;

  CustomSection({
    this.sections = const [],
  });

  CustomSection.fromJson(Map<String, dynamic> json)
      : sections =
            json['sections'].map<Section>((s) => Section.fromJson(s)).toList();

  Map<String, dynamic> toJson() => {
        'sections': sections.map((s) => s.toJson()).toList(),
      };
}

const String defaultName = 'Untitled Section';

// get the measure range for a section
String getMeasureRangeSection(List<Section> sections, int index) {
  int totalMeasures = 0;
  for (int i = 0; i < sections.length; i++) {
    // not the current metronome
    if (i != index) {
      totalMeasures += sections[i].measures;
    } else // current metronome
    {
      String range = '';
      if (sections[i].measures != 0) {
        if ((totalMeasures + 1) != (totalMeasures + sections[i].measures)) {
          range =
              '${(totalMeasures + 1)} - ${totalMeasures + sections[i].measures}';
        } else {
          range = '${(totalMeasures + 1)}';
        }
      } else {
        range = '${(totalMeasures + 1)} - ∞';
      }

      return range;
    }
  }

  // error
  debugPrint('Error: getMeasureRange(): index out of range');
  return '';
}

// get the section from a measure number
String getSection(List<Section> sections, int measure) {
  int totalMeasures = 0;
  for (int i = 0; i < sections.length; i++) {
    totalMeasures += sections[i].measures;
    if (measure <= totalMeasures || sections[i].measures == 0) {
      return sections[i].name;
    }
  }

  return 'Undefined';
}

int getSectionIndex(List<Section> sections, int measure) {
  int totalMeasures = 0;
  for (int i = 0; i < sections.length; i++) {
    totalMeasures += sections[i].measures;
    if (measure <= totalMeasures) {
      return i;
    }
  }

  // error
  debugPrint('Error: getSectionIndex(): measure out of range');
  return 0;
}

List<String> getSectionNames(List<Section> sections) {
  List<String> names = [];
  for (int i = 0; i < sections.length; i++) {
    names.add(sections[i].name);
  }

  return names;
}

int getSectionMeasure(List<Section> sections, String section) {
  int totalMeasures = 0;
  for (int i = 0; i < sections.length; i++) {
    if (sections[i].name == section) {
      return totalMeasures + 1;
    } else {
      totalMeasures += sections[i].measures;
    }
  }

  // error
  debugPrint('Error: getSectionMeasure(): section not found');
  return -1;
}

class SharedPref {
  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? '');
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

//saving and loading
SharedPref sharedPref = SharedPref();

// get a new metronome name and add (1) if it already exists
String getMetronomeName(String name) {
  // check if name already exists
  for (int i = 0; i < userData.metronomeData.length; i++) {
    if (userData.metronomeData[i].name == name) {
      return getMetronomeName('$name(1)');
    }
  }

  return name;
}
