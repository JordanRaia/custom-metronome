// global variable that holds the List of Metronome objects
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

class UserData {
  // all the user's saved metronomes
  List<CustomMetronome> metronomeData;

  // all the user's saved sections
  List<CustomSection> sectionData;

  // the user's current metronome and section
  int currentIndex;

  UserData({
    this.currentIndex = 0,
    this.metronomeData = const [],
    this.sectionData = const [],
  });
}

// metronome object
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
      if (metronomes[i].measures != -1) {
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
  debugPrint('Error: getCurrentMeasure(): measure out of range');
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
  debugPrint('Error: getMetronomeIndex(): measure out of range');
  return -1;
}

// default metronome
int defaultTempo = 120;
int defaultBeatsPerMeasure = 4;
int defaultTimeSignature = 4;
int defaultMeasures = -1;

// user start time
int userMeasure = 1;

// section object
class Section {
  // name of the section
  String name;

  // number of measures in the section, -1 indicates infinite measures
  int measures;

  Section({
    this.name = 'Untitled Section',
    this.measures = -1,
  });
}

// custom Section object
class CustomSection {
  // list of the individual sections
  List<Section> sections;

  CustomSection({
    this.sections = const [],
  });
}

String defaultName = 'Untitled Section';

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
      if (sections[i].measures != -1) {
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
    if (measure <= totalMeasures) {
      return sections[i].name;
    }
  }

  // error
  debugPrint('Error: getSection(): measure out of range');
  return '';
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
  return -1;
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

class UserStorage {
  // get the user data
  Future<String> getUserData() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  // set the user data
  Future<File> setUserData(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(data);
  }

  // get local path on system
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // reference to the file location
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }
}
