import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';

class EditTempo extends StatefulWidget {
  const EditTempo({super.key});

  @override
  EditTempoState createState() => EditTempoState();
}

class EditTempoState extends State<EditTempo> {
  // Edit a Metronome
  void showEditTempo(BuildContext context, int index, Metronome metronome) {
    final tempoController =
        TextEditingController(text: metronome.tempo.toString());
    final beatsController =
        TextEditingController(text: metronome.beatsPerMeasure.toString());
    final timeController =
        TextEditingController(text: metronome.timeSignature.toString());
    final measuresController =
        TextEditingController(text: metronome.measures.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Metronome ${index + 1}'),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextFormField(
              controller: tempoController,
              decoration: const InputDecoration(
                labelText: 'Tempo',
                hintText: 'Enter a tempo',
              ),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50,
                  child: DropdownButtonFormField(
                    items: [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12',
                    ].map((beatsPerMeasure) {
                      return DropdownMenuItem(
                        value: beatsPerMeasure,
                        child: Text(beatsPerMeasure),
                      );
                    }).toList(),
                    onChanged: (value) {
                      beatsController.text = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Beats',
                    ),
                    value: metronome.beatsPerMeasure.toString(),
                  ),
                ),
                const Text('/', style: TextStyle(fontSize: 40)),
                SizedBox(
                  width: 50,
                  child: DropdownButtonFormField(
                    items: [
                      '4',
                      '8',
                      '16',
                      '32',
                    ].map((timeSignature) {
                      return DropdownMenuItem(
                        value: timeSignature,
                        child: Text(timeSignature),
                      );
                    }).toList(),
                    onChanged: (value) {
                      timeController.text = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Value',
                    ),
                    value: metronome.timeSignature.toString(),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: measuresController,
              decoration: const InputDecoration(
                labelText: 'Measures',
                hintText: 'Enter the number of measures',
              ),
              keyboardType: TextInputType.number,
            ),
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  int tempo =
                      int.tryParse(tempoController.text) ?? defaultTempo;
                  int beats = int.tryParse(beatsController.text) ??
                      defaultBeatsPerMeasure;
                  int time =
                      int.tryParse(timeController.text) ?? defaultTimeSignature;
                  int measures =
                      int.tryParse(measuresController.text) ?? defaultMeasures;

                  metronomes[index] = Metronome(
                    tempo: tempo,
                    beatsPerMeasure: beats,
                    timeSignature: time,
                    measures: measures,
                  );
                });
                // save changes
                sharedPref.save("user", userData);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Add a new Meronome
  void showAddTempo(BuildContext context) {
    final tempoController = TextEditingController();
    final beatsController =
        TextEditingController(text: defaultBeatsPerMeasure.toString());
    final timeController =
        TextEditingController(text: defaultTimeSignature.toString());
    final measuresController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Metronome'),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextFormField(
              controller: tempoController,
              decoration: const InputDecoration(
                labelText: 'Tempo',
                hintText: 'Enter a tempo',
              ),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50,
                  child: DropdownButtonFormField(
                    items: [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                      '9',
                      '10',
                      '11',
                      '12',
                    ].map((beatsPerMeasure) {
                      return DropdownMenuItem(
                        value: beatsPerMeasure,
                        child: Text(beatsPerMeasure),
                      );
                    }).toList(),
                    onChanged: (value) {
                      beatsController.text = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Beats',
                    ),
                  ),
                ),
                const Text('/', style: TextStyle(fontSize: 40)),
                SizedBox(
                  width: 50,
                  child: DropdownButtonFormField(
                    items: [
                      '4',
                      '8',
                      '16',
                      '32',
                    ].map((timeSignature) {
                      return DropdownMenuItem(
                        value: timeSignature,
                        child: Text(timeSignature),
                      );
                    }).toList(),
                    onChanged: (value) {
                      timeController.text = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Value',
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: measuresController,
              decoration: const InputDecoration(
                labelText: 'Measures',
                hintText: 'Enter the number of measures',
              ),
              keyboardType: TextInputType.number,
            ),
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  int tempo =
                      int.tryParse(tempoController.text) ?? defaultTempo;
                  int beats = int.tryParse(beatsController.text) ??
                      defaultBeatsPerMeasure;
                  int time =
                      int.tryParse(timeController.text) ?? defaultTimeSignature;
                  int measures =
                      int.tryParse(measuresController.text) ?? defaultMeasures;

                  metronomes.add(Metronome(
                    tempo: tempo,
                    beatsPerMeasure: beats,
                    timeSignature: time,
                    measures: measures,
                  ));
                });
                // save changes
                sharedPref.save("user", userData);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
            child: Text((userData.metronomeData[userData.currentIndex].name))),
        actions: [
          IconButton(
            onPressed: () {
              showAddTempo(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
          itemCount: metronomes.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: const Icon(Icons.music_note),
                title: Text((metronomes[index].tempo.toString())),
                subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${metronomes[index].beatsPerMeasure}'
                          '/${metronomes[index].timeSignature}'),
                      Text(getMeasureRangeMetronome(metronomes, index)),
                    ]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        showEditTempo(context, index, metronomes[index]);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          metronomes.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ));
          }),
    );
  }
}
