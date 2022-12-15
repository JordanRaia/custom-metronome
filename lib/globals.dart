// global variable that holds the List of Metronome objects
import 'package:flutter/material.dart';

// testing metronomes
List<Metronome> metronomes = [
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

// testing section
List<Section> sections = [
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

int defaultTempo = 120;
int defaultBeatsPerMeasure = 4;
int defaultTimeSignature = 4;
int defaultMeasures = -1;

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

String defaultName = 'Untitled Section';

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
