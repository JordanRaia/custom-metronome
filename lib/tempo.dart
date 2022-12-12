import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';

class EditTempo extends StatefulWidget {
  const EditTempo({super.key});

  @override
  EditTempoState createState() => EditTempoState();
}

class EditTempoState extends State<EditTempo> {
  @override
  Widget build(BuildContext context) {
    // TODO: Add a ListView to display the list of Metronome objects
    // TODO: Add buttons to allow editing and deletion of Metronome objects

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
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        // TODO: Add code to edit the metronome object
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // Add text fields or other widgets to
                                  // allow the user to enter the updated values
                                  DropdownButton<int>(
                                    items: List.generate(
                                            200 - 40 + 1, (index) => index + 40)
                                        .map((tempo) => DropdownMenuItem<int>(
                                              value: tempo,
                                              child: Text(tempo.toString()),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      // Update the tempo value
                                      // in the metronomes list
                                      setState(() {
                                        metronomes[index].tempo = value!;
                                      });
                                    },
                                  ),
                                  Row(children: [
                                    const Text('Time Signature: '),
                                    DropdownButton<int>(
                                      items: List.generate(
                                              12, (index) => index + 1)
                                          .map((beatsPerMeasure) =>
                                              DropdownMenuItem<int>(
                                                value: beatsPerMeasure,
                                                child: Text(
                                                    beatsPerMeasure.toString()),
                                              ))
                                          .toList(),
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
                                      items: [4, 8, 16, 32]
                                          .map((timeSignature) =>
                                              DropdownMenuItem<int>(
                                                value: timeSignature,
                                                child: Text(
                                                    timeSignature.toString()),
                                              ))
                                          .toList(),
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
