import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';

class EditMetronome extends StatefulWidget {
  const EditMetronome({super.key});

  @override
  EditMetronomeState createState() => EditMetronomeState();
}

class EditMetronomeState extends State<EditMetronome> {
  // Edit a Section
  void showEditMetronome(BuildContext context, int index, Section section) {
    final nameController = TextEditingController(text: section.name);
    final measuresController =
        TextEditingController(text: section.measures.toString());

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
                    sections[index].name = nameController.text;
                    sections[index].measures =
                        int.parse(measuresController.text);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
  }

  // add a new section
  void showAddSection(BuildContext context) {
    final nameController = TextEditingController();
    final measuresController = TextEditingController();

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
                    String name = '';
                    if (nameController.text == '') {
                      name = defaultName;
                    } else {
                      name = nameController.text;
                    }
                    int measures = int.tryParse(measuresController.text) ??
                        defaultMeasures;

                    sections.add(Section(name: name, measures: measures));
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
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
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(sections[index].name.toString()),
            subtitle: Text(getMeasureRangeSection(sections, index)),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      showEditMetronome(context, index, sections[index]);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        sections.removeAt(index);
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
