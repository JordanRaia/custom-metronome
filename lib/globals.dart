// global variable that holds the List of Metronome objects
List<Metronome> metronomes = [
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
    measures: 2,
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
