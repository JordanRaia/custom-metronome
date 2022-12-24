import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';

class EditMetronome extends StatefulWidget {
  const EditMetronome({super.key});

  @override
  EditMetronomeState createState() => EditMetronomeState();
}

class EditMetronomeState extends State<EditMetronome> {
  // Edit a Section
  void showEditMetronome(
      BuildContext context, int index, CustomMetronome metronome) {
    final nameController = TextEditingController(text: metronome.name);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Section ${nameController.text}'),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter a name for this section',
                ),
                keyboardType: TextInputType.text,
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
                    userData.metronomeData[index].name = nameController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
  }

  void showAddSection(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Section'),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter a name for this section',
              ),
              keyboardType: TextInputType.text,
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
                setState(
                  () {
                    String name = '';
                    if (nameController.text == '') {
                      name = defaultMetronomeName;
                    } else {
                      name = nameController.text;
                    }

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
        title: const Text('Metronomes'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAddSection(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userData.metronomeData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(userData.metronomeData[index].name),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      showEditMetronome(
                          context, index, userData.metronomeData[index]);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (userData.metronomeData.length == 1) {
                          return;
                        } else {
                          userData.metronomeData.removeAt(index);
                        }
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
