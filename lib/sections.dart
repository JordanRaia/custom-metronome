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
                      // showEditSection(context, index, metronomes[index]);
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
