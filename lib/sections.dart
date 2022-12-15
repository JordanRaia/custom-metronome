import 'package:flutter/material.dart';
import 'package:custom_metronome/globals.dart';

class EditSection extends StatefulWidget {
  const EditSection({super.key});

  @override
  EditSectionState createState() => EditSectionState();
}

class EditSectionState extends State<EditSection> {
  // Edit a Section
  void showEditSection(BuildContext context, int index, Section section) {
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
                      showEditSection(context, index, sections[index]);
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
