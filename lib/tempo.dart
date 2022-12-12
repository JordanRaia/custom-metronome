import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';

class EditTempo extends StatefulWidget {
  const EditTempo({super.key});

  @override
  EditTempoState createState() => EditTempoState();
}

class EditTempoState extends State<EditTempo> {
  // Create a list of items for the DropdownButton
  final tempoDrop = List.generate(200 - 40 + 1, (index) => index + 40)
      .map((tempo) => DropdownMenuItem<int>(
            value: tempo,
            child: Text(tempo.toString()),
          ))
      .toList();

  final beatDrop = List.generate(12, (index) => index + 1)
      .map((beatsPerMeasure) => DropdownMenuItem<int>(
            value: beatsPerMeasure,
            child: Text(beatsPerMeasure.toString()),
          ))
      .toList();

  final timeDrop = [4, 8, 16, 32]
      .map((timeSignature) => DropdownMenuItem<int>(
            value: timeSignature,
            child: Text(timeSignature.toString()),
          ))
      .toList();

  final measureDrop = List.generate(100, (index) => index + 1)
      .map((measures) => DropdownMenuItem<int>(
            value: measures,
            child: Text(measures.toString()),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Untitled'),
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
                title: Text(metronomes[index].tempo.toString()),
                subtitle: Text('${metronomes[index].beatsPerMeasure}'
                    '/${metronomes[index].timeSignature}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${(metronomes[index].measures)}  ',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Icon(Icons.queue_music),
                    const Text('                 '),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // Add text fields or other widgets to
                                  // allow the user to enter the updated values
                                  Row(
                                    children: [
                                      const Text('               Tempo: '),
                                      DropdownButton<int>(
                                        value: metronomes[index].tempo,
                                        items: tempoDrop,
                                        onChanged: (value) {
                                          // Update the tempo value
                                          // in the metronomes list
                                          setState(() {
                                            metronomes[index].tempo = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(children: [
                                    const Text('Time Signature: '),
                                    DropdownButton<int>(
                                      value: metronomes[index].beatsPerMeasure,
                                      items: beatDrop,
                                      onChanged: (value) {
                                        // Update the beatsPerMeasure value
                                        // in the metronomes list
                                        setState(() {
                                          metronomes[index].beatsPerMeasure =
                                              value!;
                                        });
                                      },
                                    ),
                                    const Text('/'),
                                    DropdownButton<int>(
                                      value: metronomes[index].timeSignature,
                                      items: timeDrop,
                                      onChanged: (value) {
                                        // Update the beatsPerMeasure value
                                        // in the metronomes list
                                        setState(() {
                                          metronomes[index].timeSignature =
                                              value!;
                                        });
                                      },
                                    )
                                  ]),
                                  Row(
                                    children: [
                                      const Text('         Measures: '),
                                      DropdownButton<int>(
                                        value: metronomes[index].measures,
                                        items: measureDrop,
                                        onChanged: (value) {
                                          // Update the tempo value
                                          // in the metronomes list
                                          setState(() {
                                            metronomes[index].measures = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  // Add more fields for the other
                                  // properties of the Metronome object

                                  // Add a save button to save
                                  // the updated values
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              ));
                            });
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
